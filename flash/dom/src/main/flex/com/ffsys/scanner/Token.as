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
		private var _scanner:Scanner;
		
		private var _children:Vector.<Token>;
		private var _groups:Object;
		private var _capture:Boolean = true;
		private var _maximum:int = -1;
		private var _discardable:Boolean = false;
		private var _expandable:Boolean = false;
		private var _filters:Boolean = true;
		
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
		* 	The scanner this token belongs to.
		*/
		public function get scanner():Scanner
		{
			return _scanner;
		}
		
		/**
		* 	@private
		*/
		internal function setScanner( scanner:Scanner ):void
		{
			_scanner = scanner;
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
		* 	A collection of token matches that represent
		* 	nested named groups for this token.
		*/
		public function get groups():Object
		{
			if( _groups == null )
			{
				_groups = new Object();
			}
			return _groups;
		}
		
		public function set groups( value:Object ):void
		{
			_groups = value;
		}
		
		/**
		* 	Clears all matches stored by this token.
		*/
		public function clear():void
		{
			if( length > 0 )
			{
				var i:int = this.length - 1;
				while( length > 0 )
				{
					splice( i, 1 );
					i--;
				}
			}
			matched = null;
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
		* 	Determines the maximum number of times
		* 	that this token can match.
		* 
		* 	Any token matches after this number of matches
		* 	are discarded from the result list and passed
		* 	to be disposed.
		*/
		public function get maximum():int
		{
			return _maximum;
		}
		
		public function set maximum( value:int ):void
		{
			_maximum = value;
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
		* 	Performs expansion of previously matched
		* 	groups.
		* 
		* 	@param scanner The scanner that created
		* 	this token match.
		*/
		public function expand( scanner:Scanner ):void
		{
			//find the index we matched at
			//var index:int = scanner.index( this );
			
			//
			
			/*
			trace("Token::expand()",
				this, scanner );			
			*/
			
			//omit the first match as that was this token's
			//complete match
			var tmp:Array = slice( 1 );
			
			var m:String = null;	//the matched string
			var tkn:Token = null;	//any token located from a scan on a match
			
			for( var i:int = 0;i < tmp.length;i++ )
			{
				m = tmp[ i ] as String;
					
				//trace("Token::expand()", "[COMPARING]", m );				
				
				if( m != null )
				{
					tkn = scanner.exec( m, this );				
					
					if( tkn != null )
					{
						//trace("Token::expand()", "[FOUND EXPANSION MATCH]", tkn, m );
						children.push( tkn.clone() );
						continue;
					}
				}
			}
			
			trace("Token::expand()", "[EXPANDED]", children );
		}
		
		/**
		* 	Determines whether this token filters invalid
		* 	matches before assigning matches to this token.
		* 
		* 	The default value is <code>true</code>.
		* 
		* 	An invalid match is considered to be a duplicate,
		* 	null, undefined or an empty string.
		*/
		public function get filters():Boolean
		{
			return _filters;
		}
		
		public function set filters( value:Boolean ):void
		{
			_filters = value;
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
		* 
		* 	@param target A specific array to filter.
		* 
		* 	@return A filtered version of the array.
		*/
		public function filtered( target:Array = null ):Array
		{
			if( target == null )
			{
				target = this;
			}
			
			if( target.length == 0 )
			{
				return target;
			}
			return target.filter( doFilter );
		}
		
		/**
		* 	@private
		*/
		private function doFilter( item:*, index:int, array:Array ):Boolean
		{
			var i:int = -1;
			if( item == undefined
				|| item == null
				|| item == ""
				|| ( ( i = array.lastIndexOf( item ) ) > -1 ) && i != index )
			{
				return false;
			}
			return true;
		}
		
		public function equals( tkn:Token ):Boolean
		{
			return ( tkn != null && ( tkn.id == this.id || tkn.name == this.name ) );
		}
		
		public function index( tokens:Vector.<Token> ):int
		{
			if( tokens != null )
			{
				var tkn:Token = null;
				for( var i:int = 0;i < tokens.length;i++ )
				{
					tkn = tokens[ i ];
					if( tkn.equals( this ) )
					{
						return i;
					}
				}
			}
			return -1;
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
					//
					clear();
					
					var tmp:Array = re.exec( candidate );
					
					//keep track of any match index
					//this.index = tmp.index;
					
					
					//clean the input candidate
					delete tmp.input;
					delete tmp.index;					
					
					if( tmp[ 1 ] is String )
					{
						matched = tmp[ 1 ];
					}
					
					var z:String = null;
					var m:String = null;
					var i:int = 0;
					for( z in tmp )
					{
						m = tmp[ z ] as String;
						
						var tkns:Vector.<Token> = null;
						var tkn:Token = null;
						
						//trace("Token::compare()", z, m );
						
						if( m
							&& isNaN( Number( z ) )
						 	&& z != name )
						{
							//try to find a match token that
							//corresponds to the name of the capturing group
							tkns = scanner.filter( z );
							
							if( tkns.length > 0 )
							{
								tkn = tkns[ 0 ];
								
								if( tkn != null )
								{
									tkn = tkn.clone();
									tkn.matched = tmp[ z ];
									
									/*
									trace("Token::compare()", "[FOUND NAMED GROUP]",
										z, tmp[ z ], this.name, this.scanner, tkn );
									*/
										
									//we need to know the group index
									//so that named capturing groups
									//can create children that are in the
									//order that the named groups were matched
									for( i = 0;i < tmp.length;i++ )
									{
										if( tmp[ i ] == m )
										{
											//trace("Token::compare()",  "[FOUND NAMED GROUP MATCH INDEX]", z, m, i );
											//give the token a reference to it's group index match
											tkn.groupIndex = i;
											break;
										}
									}
									
									groups[ z ] = tkn;
									children.push( tkn );									
								}
							}
						}
					}
					
					
					
					//post-process the groups to ensure the children
					//order matches the order of the groups					
					if( children.length > 0 )
					{
						//trace("Token::compare() [BEFORE SORT]", children );
						children = children.sort(
							orderByGroupIndex
						);
					
						trace("Token::compare() [AFTER SORT]", children );
					}
										
					//omit the first entry which is the complete match
					//so that we only maintain parenthetical groups in matched results
					tmp = tmp.slice( 1 );
					
					var c:int = -1;
					for( i = 0;i < tmp.length;i++ )
					{
						//automatically filter after matching
						if( filters && doFilter( tmp[ i ], i, tmp ) )
						{
							this[ ++c ] = tmp[ i ];
						}else if( !filters )
						{
							this[ ++c ] = tmp[ i ];							
						}
					}
				}
				return matches == true || matched.length > 0;
			}
			return matches;
		}
		
		private function orderByGroupIndex( a:Token, b:Token ):Number
		{
			if( a.groupIndex < b.groupIndex )
			{
				return -1;
			}else if( a.groupIndex == b.groupIndex )
			{
				return 0;
			}
			return 1;
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
			copy.maximum = maximum;
			copy.discardable = discardable;
			copy.expandable = expandable;
			copy.filters = filters;
			copy.children = children.slice();
			
			copy.setScanner( this.scanner );
			
			//TODO: copy dynamic properties
			
			for( var i:int = 0;i < length;i++ )
			{
				copy[ i ] = this[ i ];
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
			return "[object Token]["
				+ ( name != null ? name : id ) + "] "
				+ ( /^\s+$/.test( matched ) ? "\\s+" : matched )
				//+ ( length > 0 ? ( " | " + join( "," ) ) : "" );
				+ ( children.length > 0 ? ( " >>> " + children.join( ", " ) ) : "" );
		}
	}
}