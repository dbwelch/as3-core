package com.ffsys.scanner
{
	/**
	*	Represents a text token.
	* 
	* 	A token is used both to define the text
	* 	match and as a result token when a tokenizer
	* 	places a result token in it's collection of results.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	public class Token extends Object
	{	
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
		
		private var _results:Array;
		private var _capture:Boolean = true;
		
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
		* 	Determines whether this token can be
		* 	added to a can result set.
		* 
		* 	The default value is <code>true</code>.
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
		* 	Determines whether this token
		* 	is an entire match.
		*/
		public function isMatch():Boolean
		{
			return match != null;
		}
		
		/**
		* 	Any resulting regular expression
		* 	matches from the last time the
		* 	<code>compare</code> method was invoked.
		*/
		public function get results():Array
		{
			return _results;
		}
		
		public function set results( value:Array ):void
		{
			_results = value;
		}
		
		/**
		* 	@private
		*/
		private function filter( item:*, index:int, array:Array ):Boolean
		{
			if( item == null
				|| item.match( /^\s*$/ )
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
					if( tmp[ 1 ] is String )
					{
						matched = tmp[ 1 ];
					}
					//omit the first entry which is the complete match
					//so that we only maintain parenthetical groups in matched results
					_results = tmp.slice( 1 );
					_results = _results.filter( filter, null );
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
				if( isMatch() )
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
			copy.results = results.slice();
			return copy;
		}
		
		/**
		* 	Retrieves a string representation of this token.
		* 
		* 	@return A string representation of this token.
		*/
		public function toString():String
		{
			return "[object Token]["
				+ ( name != null ? name : id ) + "] "
				+ ( /^\s+$/.test( matched ) ? "\\s+" : matched );
		}
	}
}