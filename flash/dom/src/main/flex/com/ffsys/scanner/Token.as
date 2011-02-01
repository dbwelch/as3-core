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
	dynamic public class Token extends Scanner
	{	
		private var _scanner:Scanner;
		
		private var _children:Vector.<Token>;
		private var _groups:Object;
		private var _capture:Boolean = true;
		private var _maximum:int = -1;
		private var _discardable:Boolean = false;
		//private var _expandable:Boolean = false;
		private var _clean:Boolean = true;
		
		private var _delimiter:RegExp;
		private var _repeater:RegExp;
		
		private var _tokens:Vector.<Token>;
		private var _block:BlockToken;
		
		private var _merges:Boolean = true;
		
		/**
		* 	A regular expression or string indicating
		* 	that this token must be an entire
		* 	match.
		*/
		private var _match:RegExp;
		
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
		* 	Creates a <code>Token</code> instance.
		* 
		* 	@param id The identifier for the token.
		*/
		public function Token( id:int = 0, source:Object = null )
		{
			super();
			this.id = id;
			
			//TODO: handle constructing a regex from a string source
			
			if( source is RegExp )
			{
				this.match = source as RegExp;
			}
			
			//trace("[INIT] Token::init()", this.id, ( source is RegExp ),  this.match != null );
		}
		
		/**
		* 	Determines whether when adjacent tokens
		* 	of this type are encountered the matched
		* 	results are merged into the existing matched
		* 	token.
		* 
		* 	The default value is <code>true</code>.
		*/
		public function get merges():Boolean
		{
			return _merges;
		}
		
		public function set merges( value:Boolean ):void
		{
			_merges = value;
		}
		
		/**
		* 	The match produced by the first capturing
		* 	group of the main <code>match</code> regular
		* 	expression.
		*/
		public function get matched():String
		{
			return this[ 0 ] as String;
		}
		
		public function set matched( value:String ):void
		{
			if( value != null )  
			{
				this[ 0 ] = value;
			}else
			{
				shift();
			}
		}
		
		/**
		*	The main pattern for this token match.
		*/
		public function get match():RegExp
		{
			return _match;
		}
		
		public function set match( value:RegExp ):void
		{
			_match = value;
		}
		
		/**
		* 	A regular expression that indicates that this
		* 	token can be repeated using a <code>delimiter</code>
		* 	and <code>repeater</code>.
		*/
		public function get delimiter():RegExp
		{
			return _delimiter;
		}
		
		public function set delimiter( value:RegExp ):void
		{
			_delimiter = value;
		}
		
		/**
		* 	A regular expression that indicates that this
		* 	token can be repeated.
		*/
		public function get repeater():RegExp
		{
			return _repeater;
		}
		
		public function set repeater( value:RegExp ):void
		{
			_repeater = value;
		}
		
		/**
		* 	Handles the processing for any <code>delimiter</code>
		*	and <code>repeater</code>.
		* 
		* 	@param candidate The source candidate to test for
		* 	<code>delimiter</code> and <code>repeater</code> matching.
		* 
		* 	@return An object encapsulating the repeater matches and source
		* 	candidate string.
		*/
		public function repeats( candidate:String, output:Object = null ):Object
		{
			if( output == null )
			{
				output = {};
				output.match = "";
				output.source = candidate;
				output.delimiters = [];
				output.repeaters = [];
				output.matched = [];
				output.length = 0;
				//output.extracted = false;
			}
			
			var results:Array = delimiter.exec( output.source );
			
			/*
			if( matched != null && !output.extracted )
			{
				var index:int = matched.search( delimiter );
				if( index > -1 && index < ( matched.length - 1 ) )
				{					
					//trace("[FOUND MATCH WITH DELIMITER BEFORE ] Token::repeats()", name, matched );					
					
					//var startmatch:String = matched.substr( 0, index );
					//output.source = matched.substr( index ) + output.source;
					//output.extracted = true;
					
					//matched = startmatch;
					
					//trace("[FOUND MATCH WITH DELIMITER AFTER] Token::repeats()", name, matched, startmatch );
				}	
			}
			*/
			
			if( delimiter == null
				|| repeater == null
				|| !delimiter.test( output.source ) )
			{
				return output;
			}			
			
			//results = delimiter.exec( output.source );			
			
			results = delimiter.exec( output.source );
			if( results == null )
			{
				return output;
			}			

			//got a group match on the delimiter
			if( ( results[ 1 ] as String ) != null && results.index == 0 )
			{
				output.delimiters.push( results[ 1 ] );
				output.match += results[ 1 ];
				
				//trace("Token::repeats()", "'" + output  + "'" );
				
				//chomp the match
				output.source = output.source.substr( results[ 1 ].length );
				
				//trace("[DELIMITER] Token::repeats()", name, output, repeater != null );
				
				if( repeater != null )
				{
					results = repeater.exec( output.source );
					if( results == null )
					{
						return output;
					}
					//got a group match on the repeater
					if( ( results[ 1 ] as String ) != null && results.index == 0 )
					{
						output.repeaters.push( results[ 1 ] );
						output.match += results[ 1 ];		
						
						//add the delimiter match
						push( output.delimiters[ output.delimiters.length - 1 ] );
						output.matched.push( output.delimiters[ output.delimiters.length - 1 ] );
						
						//add the repeater match
						push( output.repeaters[ output.repeaters.length - 1 ] );
						output.matched.push( output.repeaters[ output.repeaters.length - 1 ] );
						
						output.length++;
						
						/*
						trace("[REPEATER] Token::repeats()",
							name, output, output.length, output.matched );
						*/
						
						//chomp the match
						output.source = output.source.substr(
							results[ 1 ].length );
							
						//try to recurse
						if( delimiter.test( output.source ) )
						{
							return repeats( output.source, output );
						}
					}
				}
			}
			
			return output;
		}
		
		/**
		* 	A block token associated with this token.
		* 
		* 	A block token opens a block for this token
		* 	match and then appends all matches within the
		* 	block to this token.
		*/
		public function get block():BlockToken
		{
			return _block;
		}
		
		public function set block( value:BlockToken ):void
		{
			_block = value;
		}
		
		/**
		* 	Determines whether a valid block has been assigned
		* 	to this token.
		*/
		public function hasBlock():Boolean
		{
			return _block is BlockToken && block.start != null && block.end != null;
		}
		
		/**
		* 	TODO
		*/
		public function get open():Boolean
		{
			return hasBlock() && block.open;
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
		* 	A list of tokens that this token should match
		* 	against.
		*/
		
		/*
		public function get tokens():Vector.<Token>
		{
			if( _tokens == null )
			{
				return new Vector.<Token>();
			}
			return _tokens;
		}
		
		public function set tokens( value:Vector.<Token> ):void
		{
			_tokens = value;
		}	
		*/
		
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
		
		/*
		public function get expandable():Boolean
		{
			return _expandable;
		}
		
		public function set expandable( value:Boolean ):void
		{
			_expandable = value;
		}
		*/
		
		/**
		* 	Performs expansion of previously matched
		* 	groups.
		* 
		* 	@param scanner The scanner that created
		* 	this token match.
		*/
		
		/*
		public function expand( scanner:Scanner ):void
		{
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
		*/
		
		/**
		* 	Determines whether this token cleans invalid
		* 	matches before assigning matches to this token.
		* 
		* 	The default value is <code>true</code>.
		* 
		* 	An invalid match is considered to be a duplicate,
		* 	null, undefined or an empty string.
		*/
		public function get clean():Boolean
		{
			return _clean;
		}
		
		public function set clean( value:Boolean ):void
		{
			_clean = value;
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
		
		/*
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
		*/
		
		/**
		* 	Performs comparison against a candidate string.
		* 
		* 	@param candidate A candidate string.
		* 
		* 	@return Whether this token matches the candidate.
		*/
		override public function compare( candidate:String, tkn:Token ):Boolean
		{
			var matches:Boolean = test( candidate );
			if( matches )
			{
				//if( match is String )
				//{
				//	matched = ( match as String );
				//}else if( match is RegExp )
				//{
					//
					clear();
					
					var tmp:Array = match.exec( candidate );
					
					//keep track of any match index
					//this.index = tmp.index;
					
					
					//clean the input candidate
					delete tmp.input;
					delete tmp.index;					
					
					if( tmp[ 1 ] is String )
					{
						matched = tmp[ 1 ];
					}
					
					//test for the presence of a required block
					if( hasBlock() && block.required )
					{
						candidate = candidate.substr( matched.length );
						if( !block.start.test( candidate ) )
						{
							return false;
						}
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
							tkns = scanner.search( z );
							
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
					
						//trace("Token::compare() [AFTER SORT]", children );
					}
										
					//omit the first entry which is the complete match
					//so that we only maintain parenthetical groups in matched results
					tmp = tmp.slice( 1 );
					
					var c:int = -1;
					var val:String;
					for( i = 0;i < tmp.length;i++ )
					{
						val = tmp[ i ] as String;
						
						if( val != null )
						{
							//automatically filter after matching
							if( clean && doFilter( val, i, tmp ) )
							{
								this[ ++c ] = val;
							}else if( !clean )
							{
								this[ ++c ] = val;			
							}
						}
					}
				//}
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
		public function test( candidate:String ):Boolean
		{
			var matches:Boolean = false;
			if( candidate != null && match != null )
			{
				matches = match.test( candidate );
			}
			return matches;
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
			copy.name = name;
			//copy.matched = matched;
			copy.capture = capture;
			copy.maximum = maximum;
			copy.discardable = discardable;
			//copy.expandable = expandable;
			copy.clean = clean;
			copy.block = block;
			copy.merges = merges;
			
			copy.repeater = repeater;
			copy.delimiter = delimiter;
			copy.tokens = tokens;
			
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
			var output:String = "[object Token][";
				output += ( name != null ? name : id ) + "] ";
				output += ( /^\s+$/.test( matched ) ? "\\s+" : "'" + matched + "'" );
				if( length > 1 )
				{				
					output += " | [matched(" + length + ")[" + join( "," ) + "]]";
				}
				//if( children.length > 0 )
				//{
					//output += "\n[children[" + children.join( ", " ) + "]";
				//}
			return output;
		}
	}
}