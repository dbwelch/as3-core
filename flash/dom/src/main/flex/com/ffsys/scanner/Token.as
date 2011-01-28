package com.ffsys.scanner
{
	/**
	*	Represents a text scan token.
	* 
	* 	A token is used both to define the text
	* 	match and as a result token when a scanner
	* 	places a result token in it's collection of results.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	dynamic public class Token extends Array
	{	
		private var _children:Vector.<Token>;
		private var _capture:Boolean = true;
		private var _once:Boolean = false;
		private var _discardable:Boolean = false;
		private var _expandable:Boolean = false;
		
		/**
		* 	A regular expression or string indicating
		* 	that this token must be an entire
		* 	match.
		*/
		public var match:Object;
		
		/**
		* 	An identifier that can be assigned to
		* 	this token to indicate a token type.
		*/
		public var id:int;
		
		/**
		* 	A name for this token.
		*/
		public var name:String;
		
		/**
		* 	The entire matched text for the token.
		*/
		public var matched:String;
		
		/**
		* 	Creates a <code>Token</code> instance.
		* 
		* 	@param id The identifier for the token.
		*/
		public function Token( id:int = 0, match:Object = null )
		{
			super();
			this.id = id;
			this.match = match;
		}
		
		/**
		* 	Child tokens belonging to this token.
		*/
		public function get children():Vector.<Token>
		{
			if( _children == null )
			{
				_children = new Vector.<Token>();
			}
			return _children;
		}
		
		public function set children( value:Vector.<Token> ):void
		{
			_children = value;
		}
		
		/**
		* 	Determines whether this token can be
		* 	added to a can result set.
		* 
		* 	The default value is <code>true</code>.
		* 
		* 	Set this to <code>false</code> for tokens
		* 	that are extraneous to the grammar of the scanner.
		* 
		* 	An example would be comment blocks that you want
		* 	to completely ignore or whitespace tokens
		* 	for a grammar that ignores whitespace completely.
		*/
		public function get capture():Boolean
		{
			return _capture;
		}
		
		public function set capture( value:Boolean ):void
		{
			_capture = value;
		}
		
		/**
		* 	Determines that this token should only
		* 	be matched once and any subsequent matches
		* 	should be discarded from the scanner result
		* 	set.
		* 
		* 	The default value is <code>false</code>.
		* 
		* 	When <code>once</code> is <code>true</code> 
		* 	the behaviour is equivalent to
		* 	setting <code>capture</code> to <code>false</code>
		* 	immediately after the first successful match.
		*/
		public function get once():Boolean
		{
			return _once;
		}
		
		public function set once( value:Boolean ):void
		{
			_once = value;
		}
		
		/**
		* 	Determines whether this token is treated as
		* 	a discardable match.
		* 
		* 	The default value is <code>false</code>.
		* 
		* 	When a token is treated as <code>discardable</code>
		* 	it is removed from the list of tokens the scanner
		* 	will match against after the first successful
		* 	match. This prevents any further matching of the token
		* 	as the scanner proceeds.
		* 
		* 	Set this to <code>true</code> for tokens that should
		* 	only be matched once.
		*/
		public function get discardable():Boolean
		{
			return _discardable;
		}
		
		public function set discardable( value:Boolean ):void
		{
			_discardable = value;
		}
		
		/**
		*	Determines whether this token expands
		* 	matches into child tokens.
		* 
		* 	When a token is expandable the scanner
		* 	rescans using the <code>filtered</code>
		* 	results from the last match on
		* 	<code>this</code> token attempting to match
		* 	subsequent tokens.
		* 
		* 	That is to say match tokens starting from
		* 	the index of this token +1 in the list are
		* 	rescanned.
		*/
		public function get expandable():Boolean
		{
			return _expandable;
		}
		
		public function set expandable( value:Boolean ):void
		{
			_expandable = value;
		}
		
		/**
		* 	Filters the matched results to omit
		* 	duplicates, empty strings and any
		* 	null entries.
		* 
		* 	This implementation does not cache
		* 	filtered results but retrieves a filtered
		* 	copy of this token's matches on
		* 	<em>every</em> invocation.
		*/
		public function get filtered():Array
		{
			if( length == 0 )
			{
				return this;
			}
			return this.filter( doFilter );
		}
		
		/**
		* 	@private
		*/
		private function doFilter( item:*, index:int, array:Array ):Boolean
		{
			if( item == null
				|| item == ""
				|| array.lastIndexOf( item ) != index )
			{
				return false;
			}
			return true;
		}
		
		/**
		* 	Performs comparison against a candidate string.
		* 
		* 	@param candidate A candidate string.
		* 
		* 	@return Whether this token matches the candidate.
		*/
		public function compare( candidate:String, re:RegExp = null ):Boolean
		{
			var matches:Boolean = test( candidate, re );
			if( matches )
			{
				if( re == null && match is RegExp )
				{
					re = match as RegExp;
				}		
				
				if( match is String )
				{
					matched = ( match as String );
				}else if( match is RegExp )
				{
					var tmp:Array = re.exec( candidate );
					
					//keep track of any match index
					this.index = tmp.index;
					
					if( tmp[ 1 ] is String )
					{
						matched = tmp[ 1 ];
					}
										
					//omit the first entry which is the complete match
					//so that we only maintain parenthetical groups in matched results
					for( var i:int = 1;i < tmp.length;i++ )
					{
						this[ i - 1 ] = tmp[ i ];
					}
				}
				
				return matches == true || matched.length > 0;
			}
			return matches;
		}
		
		/**
		* 	Determines whether this token matches
		* 	a candidate.
		* 
		* 	@param candidate The candidate.
		* 
		* 	@return Whether this token matches the candidate.
		*/
		public function test( candidate:String, re:RegExp = null ):Boolean
		{
			if( candidate != null )
			{
				if( re == null && match is RegExp )
				{
					re = match as RegExp;
				}
				
				var tkn:Token = null;
				if( match != null )
				{
					if( re is RegExp
						&& re.test( candidate ) )
					{
						return true;
					}else if( match is String
						&& match == candidate )
					{
						return true;
					}
				}
				
				//trace("Token::test()", this, candidate );
			}
			return false;
		}
		
		/**
		* 	Creates a clone of this token.
		* 
		* 	@param copy An existing alternative
		* 	instance to copy properties into.
		* 
		* 	@return A clone of this token.
		*/
		public function clone( copy:Token = null ):Token
		{
			if( copy == null )
			{
				copy = new Token();
			}
			copy.id = id;
			copy.match = match;
			copy.matched = matched;
			copy.name = name;
			copy.capture = capture;
			copy.once = once;
			copy.discardable = discardable;
			copy.expandable = expandable;
			copy.children = children;
			
			//copy dynamic properties
			for( var z:String in this )
			{
				copy[ z ] = this[ z ];
			}
			return copy;
		}
		
		/**
		* 	Retrieves a string representation of this token.
		* 
		* 	@return A string representation of this token.
		*/
		public function toString():String
		{
			var res:Array = this.filtered;	//point to 'this' to view unfiltered matches
			return "[object Token]["
				+ ( name != null ? name : id ) + "] "
				+ ( /^\s+$/.test( matched ) ? "\\s+" : matched )
				+ ( res.length > 0 ? ( " | " + res.join( "," ) ) : "" );
		}		
	}
}