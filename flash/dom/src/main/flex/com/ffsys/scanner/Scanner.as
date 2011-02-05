package com.ffsys.scanner
{
	/**
	* 	A lexical scanner.
	* 
	*	This class is responsible for scanning text
	* 	and producing <code>result</code> tokens
	* 	based on matches from the <code>tokens</code>
	* 	defined on this scanner.
	* 	
	* 	No <code>tokens</code> are defined by
	* 	this implementation.
	* 
	* 	Derived implementations may define
	* 	the <code>tokens</code> in the
	* 	<code>configure</code> method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	dynamic public class Scanner extends Array
	{
		/**
		* 	Used to indicate the expected number
		* 	of bytes per text character.
		* 
		* 	The default assumption is that <code>utf-8</code>
		* 	is used therefore there is one byte per character.
		* 
		* 	For larger character byte representations (<code>utf-16</code> etc.)
		* 	this value should be set to correspond to the
		* 	byte per character count in order for the
		* 	<code>bytesTotal</code> and <code>bytesLoaded</code>
		* 	to be a true representation of the number of bytes
		* 	represented by the character stream.
		*/
		public static var bytesPerCharacter:uint = 1;
		
		private var _registry:Vector.<Token>;
		private var _tokens:Vector.<Token>;
		private var _results:Vector.<Token>;
		private var _counts:Object;
		
		private var _bytesTotal:int = 0;
		private var _bytesLoaded:int = 0;
		
		private var _list:Vector.<Token>;
		
		/**
		* 	@private
		*/
		protected var _lastMatch:String;
		
		/**
		* 	@private
		*/
		protected var _source:String;
		
		/**
		* 	@private
		* 
		* 	The current token being processed.
		*/
		protected var _current:Token = null;
		
		/**
		* 	@private
		* 
		* 	The previous token.
		*/
		protected var _previous:Token;
		
		/**
		* 	Creates a <code>Scanner</code> instance.
		*/
		public function Scanner()
		{
			super();			
		}
		
		public function get bytesTotal():int
		{
			return _bytesTotal;
		}
		
		public function get bytesLoaded():int
		{
			return ( _bytesTotal - ( source.length * bytesPerCharacter ) );
		}
		
		/**
		* 	The number of characters still to be scanned.
		*/
		public function get chars():int
		{
			return source == null ? 0 : source.length;
		}
		
		/**
		* 	Determines whether a scan is complete.
		*/
		public function get complete():Boolean
		{
			return bytesTotal > 0
				&& bytesTotal == bytesLoaded
				&& chars == 0;
		}
		
		/**
		* 	Invoked on instantiation to configure
		* 	the default tokens for this scanner.
		*/
		protected function configure():void
		{
			//
		}
		
		/**
		* 	Tokenizes source text.
		* 
		* 	@param source The source to tokenize.
		* 
		* 	@return A list of tokens that matched the source text.
		*/
		public function scan( source:String ):Vector.<Token>
		{
			//nothing to do
			if( source == null )
			{
				return results;
			}
			
			//assuming utf-8 so 1 byte per character
			_bytesTotal = ( source.length * bytesPerCharacter );
			
			if( tokens.length == 0 )
			{
				//attempt to configure if no tokens specified
				configure();
			}
			
			//point the match list to the main tokens
			_list = tokens;
			
			_counts = new Object();
			_current = null;
			_source = source;
			scanSource();
			//clean up
			cleanup();
			return _results;
		}
		
		/**
		* 	The source currently being scanned.
		* 
		* 	Note this may not match the source
		* 	specified when the <code>scan</code>
		* 	method was invoked as the source is
		* 	modified during the scan.
		* 
		* 	If a scan was incomplete, for example
		* 	if no token matches, this will contain
		* 	any remaining unscanned text.
		*/
		public function get source():String
		{
			return _source;
		}
		
		/**
		* 	Invoked when parsing is complete
		* 	to clean cached temporary data.
		*/
		protected function cleanup():void
		{
			_lastMatch = null;
			_current = null;
			_previous = null;
			_counts = null;
			_list = null;
		}
		
		/**
		* 	A list of tokens that represent the scanned
		* 	results.
		*/
		public function get results():Vector.<Token>
		{
			if( _results == null )
			{
				_results = new Vector.<Token>();
			}
			return _results;
		}
		
		/**
		* 	The list of tokens this scanner should
		* 	match against.
		* 
		* 	By default tokens are matched in the order
		* 	declared in this list, therefore the token
		* 	at index zero has the highest priority and
		* 	the token at <code>n-1</code> has the lowest
		* 	priority.
		*/
		public function get tokens():Vector.<Token>
		{
			if( _tokens == null )
			{
				_tokens = new Vector.<Token>();
			}
			return _tokens;
		}
		
		public function set tokens( value:Vector.<Token> ):void
		{
			_tokens = value;
		}
		
		/**
		* 	A list of tokens that are not matched against
		* 	by the scanner but can be used when matching
		* 	token matches against named groups.
		*/
		public function get registry():Vector.<Token>
		{
			if( _registry == null )
			{
				_registry = new Vector.<Token>();				
			}
			return _registry;
		}
		
		/**
		* 	@private
		*/
		protected function chomp():String
		{
			//chomp the matched value				
			_source = source.substr( _lastMatch.length );
			_lastMatch = null;
			return _source;
		}
		
		/**
		* 	@private
		*/
		public function compare( candidate:String, tkn:Token ):Boolean
		{
			var matches:Boolean = tkn.compare( candidate, tkn );
			if( matches )
			{
				_lastMatch = tkn.matched;
			}
			return matches;
		}
		
		/**
		* 	Retrieves a token with the specified identifier.
		* 
		* 	@param id The identifier for the token.
		* 
		* 	@return A token with the specified identifier or
		* 	<code>null</code> if no token could be found.
		*/
		public function get( id:int ):Token
		{
			var tkn:Token = null;
			for each( tkn in tokens )
			{
				if( id == tkn.id )
				{
					return tkn;
				}
			}
			return null;
		}
		
		/**
		* 	Retrieves the index of the first result token
		* 	with the specified identifier.
		* 
		* 	@param token The result token to search for.
		* 	@param start An index to start searching from.
		* 
		* 	@return The index of the first result token with the specified
		* 	identifier.
		*/
		public function indexOf( token:Token, start:int = -1 ):int
		{
			return index( token, false, start, results );
		}
		
		/**
		* 	Retrieves the index of the last result token
		* 	with the specified identifier.
		* 
		* 	@param token The result token to search for.
		* 	@param start An index to start searching from.
		* 
		* 	@return The index of the last result token with the specified
		* 	identifier.
		*/
		public function lastIndexOf( token:Token, start:int = -1 ):int
		{
			return index( token, true, start, results );
		}
		
		/**
		* 	Filters result tokens by identifier.
		* 	
		* 	@param filter Either a discardable <code>int</code>
		* 	or <code>Vector.&lt;int&gt;</code>.
		* 
		* 	@return A list of matching result tokens.
		*/
		public function search( filter:*, list:Vector.<Token> = null ):Vector.<Token>
		{
			var output:Vector.<Token> = new Vector.<Token>();
			
			if( list == null )
			{
				list = tokens;
				
				//also search registry entries
				if( registry.length > 0 )
				{
					list = list.concat( registry );
				}
			}
			
			if( filter is int
				|| filter is String
				|| filter is Vector.<int>
				|| filter is Token
				|| filter is Vector.<Token> )
			{
				var i:int = 0;
				var tkn:Token = null;
				var ids:Vector.<int> = new Vector.<int>();
				
				//find the numeric id from a name filter
				if( filter is String )
				{
					for( i = 0;i < tokens.length;i++ )
					{
						tkn = tokens[ i ];
						if( tkn.name == ( filter as String ) )
						{
							ids.push( tkn.id );
							break;
						}
					}
				}				
				
				//switch token for int
				if( filter is Token )
				{
					filter = ( filter as Token ).id;
				}else if( filter is Vector.<Token> )
				{
					var input:Vector.<Token> = filter as Vector.<Token>;
					for( i = 0;i < input.length;i++ )
					{
						tkn = input[ i ];
						if( tkn != null )
						{
							ids.push( tkn.input );
						}
					}
				}
				
				if( filter is int )
				{
					ids.push( filter as int );
				}else if( filter is Vector.<int> )
				{
					ids = filter as Vector.<int>;
				}
				
				var k:int = 0;
				var id:int = -1;
				
				//match on filters ids
				for( i = 0;i < ids.length;i++ )
				{
					id = ids[ i ];
					for( k = 0;k < list.length;k++ )
					{
						tkn = list[ k ];
						if( tkn.id == id )
						{
							output.push( tkn );
						}
					}
				}
			}
			return output;
		}
		
		/**
		* 	Retrieves the index of a token.
		* 
		* 	Matching is performed on the token <code>id</code>.
		* 
		* 	@param token The token to search for.
		* 	@param backwards Whether the search is performed
		* 	from the end of the list of match tokens.
		* 	@param start An index to start searching from.
		* 	@param list A specific list of tokens to search, when
		* 	omitted the list of <em>match</em> tokens associated with this scanner
		* 	is searched.
		* 
		* 	@return The index of the match token or -1 if no token
		* 	was found.
		*/
		public function index(
			token:Token,
			backwards:Boolean = false,
			start:int = -1,
			list:Vector.<Token> = null ):int
		{
			if( token != null )
			{
				var id:int = token.id;
				if( list == null )
				{
					list = tokens;
				}
				var i:int = !backwards ? 0 : list.length - 1;
				if( start > -1 )
				{
					//clamp to match list length
					if( start < 0 )
					{
						start = 0;
					}
					if( start >= list.length )
					{
						start = list.length - 1;
					}
					i = start;
				}
				
				var tkn:Token = null;
				while( i >= 0 && i <= ( list.length - 1 ) )
				{
					tkn = list[ i ];
					if( id == tkn.id )
					{
						return i;
					}
					!backwards ? i++ : i--;
				}
			}
			return -1;
		}
		
		/**
		* 	Removes a match token from the list of <code>tokens</code>
		* 	this scanner will match against.
		* 
		* 	Matching is performed against the token <code>id</code>.
		* 
		* 	@param token The token to remove.
		* 
		* 	@return Whether the token was removed.
		*/
		public function remove( token:Token, list:Vector.<Token> = null ):Boolean
		{
			if( list == null )
			{
				list = tokens;
			}			
			var index:int = index( token, false, -1, list );
			if( index > -1 )
			{				
				list.splice( index, 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	Adds a token to the list of tokens
		* 	this scanner should match against.
		* 
		* 	@param token The token to match against.
		* 
		* 	@return Whether the token was added.
		*/
		public function add( token:Token, list:Vector.<Token> = null ):Boolean
		{
			if( token != null )
			{
				if( list == null )
				{
					list = tokens;
				}
				
				token.setScanner( this );
				if( list.indexOf( token ) == -1 )
				{
					list.push( token );
				}
			}
			return false;
		}
		
		/**
		* 	A current token being processed.
		*/
		protected function get current():Token
		{
			return _current;
		}
		
		protected function set current( value:Token ):void
		{
			/*
			if( _current != null
				&& value != null
				&& value.hasBlock() )
			{
				trace("[ASSIGNED CURRENT] Scanner::scanSource() value/open/parent:", value, value.open, value.block.parent );
			}
			*/
			
			//keep track of any previous valid token match
			if( _current != null )
			{
				
				//cannot overwrite current open blocks for the moment
				if( _current.open )
				{
					trace("Scanner::set current()", "[SKIPPING SETTING CURRENT ON CURRENT OPEN BLOCK]" );
					return;
				}
				
				_previous = _current;
			}
			
			if( _current != null
				&& _current.capture )
			{
				endToken( _current );
			}
					
			_current = value;			
			
			/*
			if( _current )
			{
				trace("[ASSIGNED CURRENT] Scanner::scanSource()", _current, _current.children.length );			
			}
			*/
		}
		
		/**
		* 	@private
		*/
		protected function scanSource():void
		{
			if( source != null )
			{
				//var i:int = 0;
				//var c:String = null;
				
				var tkn:Token = null;
				
				var results:Array = null;
				var opens:Boolean = false;
				var closes:Boolean = false;				
				
				// = tokens;
				
				//open blocks match against any tokens
				//associated with them
				
				/*
				if( _current != null
					&& _current.open
					&& _current.block.tokens.length > 0 )
				{
					list = _current.block.tokens;
					trace("[ASSIGNED OPEN BLOCK TOKENS] Scanner::scanSource()" );
				}
				*/
				
				tkn = exec( source, null, false, _list );

				//HANDLE CURRENT TOKEN REFERENCE
				if( ( tkn != null
					&& _current == null )
					&& tkn.capture )
				{
					current = tkn;
				}else if(
					tkn != null
				 	&& current != null )
				{
					//switching to a different token match
					if( tkn.id != current.id )
					{
						if( tkn.capture )
						{
							if( _current.open )
							{
								_current.block.children.push( tkn );
								
								trace("[CURRENT BLOCK OPEN - ADDING TO CURRENT CHILDREN] Scanner::scanSource()",
									_current.name,
									_current.matched,
									_current.block.children.length,
									tkn );
								
							}else
							{
								current = tkn;
							}
						}else if( !current.open )
						{
							//must clear the current reference
							//for non-capturing tokens when not in an open block
							current = null;
						}
					//same token match
					}else{
						if( !current.merges )
						{
							current = tkn;
						}
					}
				}				
				
				//TEST FOR MORE SOURCE TO PROCESS
				if( _lastMatch != null
					&& _lastMatch.length > 0
					&& source.length > 0 )
				{
					chomp();
					
					//HANDLE DELIMITER+REPEATER
					if( tkn != null
						&& tkn.delimiter != null
						&& tkn.repeater != null )
					{
						var result:Object = tkn.repeats( source );
						if( result.match.length > 0 )
						{
							//chomp any repeater match
							_lastMatch = result.match;
							chomp();
						
							/*
							trace("Scanner::scanSource()",
								"[FOUND TOKEN REPEATER]",
								result.length,
								"'" + result.matched + "'",
								result.match );
							*/
						}
					}

					//TEST FOR BLOCK OPEN/CLOSE
					if( current != null
						&& current.hasBlock() )
					{
						trace("[CURRENT TOKEN HAS BLOCK] Scanner::scanSource()" );
						
						//trace("[TESTING BLOCK] Scanner::scanSource()", current, current.block.start.exec( source ), source );

						results = current.block.start.exec( source );
						if( results != null )
						{
							var start:String = results[ 1 ] as String;

							//trace("[FOUND BLOCK TOKEN] Scanner::scanSource()", start );						

							opens = start != null && start.length > 0;
							if( opens )
							{
								trace("Scanner::scanSource()", "[STARTING BLOCK WITH CURRENT]", current );
								_lastMatch = start;
								chomp();
							}
						}

						results = current.block.end.exec( source );
						if( results != null )
						{
							var end:String = results[ 1 ] as String;
							closes = end != null && end.length > 0;						
							if( closes )
							{
								//trace("Scanner::scanSource()", "[CLOSING BLOCK WITH END]", current );								
								_lastMatch = end;
								chomp();
							}
						}

						if( opens && !closes )
						{
							current.block.open = true;
						}

						//mark an open block as closed
						if( closes )
						{
							current.block.open = false;
							
							//end the current open block
							//endToken( _previous );
						}

						//HANDLE THE BLOCK PARENT/CURRENT/PREVIOUS LOGIC

						/*
						if( current.open
							&& current.block.parent == null )
						{
							current.block.parent = _previous;
							trace("[FOUND OPENING BLOCK - ASSIGN BLOCK TOKEN PARENT REFERENCE] Scanner::scanSource()",
								current, current.block.parent );

						}else if( !current.open
							&& current.block.parent is Token )
						{
							current = Token( current.block.parent );
							trace("[FOUND CLOSING BLOCK - UPDATING BLOCK TOKEN PARENT REFERENCE] Scanner::scanSource()",
								current, current );
						}
						*/

						//assign to the open block token matches list
						if( current.open
							&& current.block.tokens.length > 0
							&& _list != current.block.tokens )
						{
							_list = current.block.tokens;
							//trace("[ASSIGNED OPEN BLOCK TOKENS] Scanner::scanSource()" );

						//reset the matches list
						}else if( !current.open
							&& _list == current.block.tokens )
						{
							//end the block token
							//endToken( current );
							
							//TODO: attempt to set the _list to parent open block tokens if necessary
							_list = tokens;
							//trace("[REASSIGNED CLOSE BLOCK TOKENS] Scanner::scanSource()" );
						}
					}
					
					if( source.length > 0 )
					{
						//SCAN ANYMORE SOURCE
						scanSource();
					}
				}
			}
		}
		
		/**
		* 	@private
		*/
		public function exec(
			candidate:String,
			token:Token = null,
			backwards:Boolean = false,
			list:Vector.<Token> = null ):Token
		{
			if( candidate != null )
			{
				if( list == null )
				{
					list = this.tokens;
				}
				
				//default start index
				var i:int = !backwards ? 0 : list.length - 1;
				
				var tkn:Token = null;
				var src:Token = null;
				while( i >= 0 && i <= ( list.length - 1 ) )
				{
					src = list[ i ];
					tkn = src.clone();

					//prevent a potential stack overflow
					//if attempting to exec on an existing token,
					//perhaps during an extraction routine
					if( token != null
						&& token.id == tkn.id )
					{
						//trace("Scanner::exec()", "[SKIPPING ON ID MATCH]", tkn );
						!backwards ? i++ : i--;
						continue;
					}
					
					if( compare( candidate, tkn ) )
					{
						//trace("Scanner::exec()", "[ FOUND TOKEN MATCH ]", tkn );
						return handleMatchedToken( tkn, src );
					}
					!backwards ? i++ : i--;
				}
			}
			return null;
		}
		
		/**
		* 	@private
		*/
		protected function handleMatchedToken(
			tkn:Token,
			src:Token ):Token
		{
			//trace("Scanner::handleMatchedToken()");
			
			if( src.maximum > -1
				&& _counts[ src ] >= src.maximum )
			{
				dispose( tkn );
				return null;
			}
			
			//keep track of the number of token matches
			if( _counts[ src ] == 0 )
			{
				_counts[ src ]++;
			}else{
				_counts[ src ] = 1;
			}
			
			//get a new token to store as result from
			//a clone of the matched token				
			if( _current == null
				|| tkn.id != _current.id )
			{
				if( tkn.discardable )
				{
					remove( tkn );
				}
				
				/*
				if( _current != null
					&& _current.capture
					//we can't end an open block until it is closed
					&& !_current.open )
				{
					endToken( _current );
				}
				*/
				
				if( tkn.capture )
				{
					results.push( tkn );
					beginToken( tkn );
				}else
				{
					dispose( tkn );
				}
			//handles merging adjacent tokens with the same id
			}else if( _current != null
				&& tkn.id == _current.id
				&& _current.merges )
			{
				_current.matched += _lastMatch;
				if( _current.capture )
				{
					token( _current );
				}
				return _current;
			}
			return tkn;
		}
		
		/**
		* 	Invoked when a token is created from
		* 	a successful match.
		* 
		* 	Non-capturing tokens do not trigger this method.
		* 
		* 	@param token The matched token.
		*/
		protected function beginToken( token:Token ):void
		{
			//
		}
		
		/**
		* 	Invoked while a token type has consecutive matches.
		* 
		* 	Non-capturing tokens do not trigger this method.
		* 
		* 	@param token The matched token.
		*/
		protected function token( token:Token ):void
		{
			//
		}
		
		/**
		* 	Invoked when the scanned proceeds to a different token.
		* 
		* 	Non-capturing tokens do not trigger this method.
		* 
		* 	@param token The matched token.
		*/
		protected function endToken( token:Token ):void
		{
			//
		}
		
		/**
		* 	Invoked with non-capturing tokens allowing
		* 	derived implementations to do something with
		* 	the token if required.
		* 
		* 	@param token The matched token that is being
		* 	ignored from the scan result set.
		*/
		protected function dispose( token:Token ):void
		{
			//
		}				
	}
}