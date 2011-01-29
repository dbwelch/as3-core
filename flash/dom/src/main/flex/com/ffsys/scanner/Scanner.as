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
	public class Scanner extends Object
	{
		private var _tokens:Vector.<Token>;
		private var _results:Vector.<Token>;
		
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
		*/
		protected var _current:Token = null;
		
		/**
		* 	Creates a <code>Scanner</code> instance.
		*/
		public function Scanner()
		{
			super();			
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
			if( tokens.length == 0 )
			{
				//attempt to configure if no tokens specified
				configure();
			}
			
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
		}
		
		/**
		* 	A list of tokens that represent the scand
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
		protected function get tokens():Vector.<Token>
		{
			if( _tokens == null )
			{
				_tokens = new Vector.<Token>();
			}
			return _tokens;
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
		protected function compare( tkn:Token, candidate:String ):Boolean
		{
			var matches:Boolean = tkn.compare( candidate );
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
		public function filter( filter:* ):Vector.<Token>
		{
			if( filter is int
				|| filter is Vector.<int>
				|| filter is Token
				|| filter is Vector.<Token> )
			{
				var i:int = 0;
				var tkn:Token = null;
				var ids:Vector.<int> = new Vector.<int>();
				
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
				
				//match on filters ids
				for( i = 0;i < ids.length;i++ )
				{
					//
				}				
			}
			return null;
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
		public function remove( token:Token ):Boolean
		{
			var index:int = index( token );
			if( index > -1 )
			{
				tokens.splice( index, 1 );
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
		public function add( token:Token ):Boolean
		{
			if( token != null )
			{
				tokens.push( token );
			}
			return false;
		}
		
		/**
		* 	@private
		*/
		protected function scanSource():void
		{
			if( source != null )
			{
				var i:int = 0;
				var c:String = null;
				var tkn:Token = null;
				
				tkn = exec( source );

				//set current tokenif none exists
				if( ( tkn != null && _current == null ) )
				{
					_current = tkn;
				}else if(
					tkn != null
				 	&& _current != null
				 	&& tkn.id != _current.id )
				{
					if( tkn.capture )
					{
						_current = tkn;
					}else{
						//must clear the current reference
						//for non-capturing tokens
						_current = null;
					}
				}
				
				if( _lastMatch != null
					&& _lastMatch.length > 0
					&& source.length > 0 )
				{
					chomp();
					//scan any remaining source
					scanSource();
				}
			}
		}
		
		/**
		* 	@private
		*/
		protected function exec(
			candidate:String,
			token:Token = null,
			backwards:Boolean = false,
			start:int = -1,
			list:Vector.<Token> = null ):Token
		{
			if( candidate != null )
			{
				if( list == null )
				{
					list = this.tokens;
				}
				
				//default start index
				var i:int = 0;
				var index:int = -1;
				
				if( token != null )
				{
					index = this.index( token, backwards, start, list );
					if( index > 0 && index < ( length -1 ) )
					{
						i = backwards ? index - 1 : index + 1;
					}else{
						i = index;
					}
				}
				
				//trace("Scanner::testTokens()", current );
				var tkn:Token = null;
				for( ;i < list.length;i++ )
				{
					tkn = list[ i ];
					if( compare( tkn, candidate ) )
					{
						return handleMatchedToken( tkn );
					}			
				}
			}
			return null;
		}
		
		/**
		* 	@private
		*/
		protected function handleMatchedToken(
			tkn:Token ):Token
		{
			//get a new token to store as result from
			//a clone of the matched token				
			if( _current == null
				|| tkn.id != _current.id )
			{
				if( tkn.discardable )
				{
					remove( tkn );
				}
				if( _current != null
					&& _current.capture )
				{
					if( _current.expandable )
					{
						_current.expand( this );
					}
					endToken( _current );
				}				
				var output:Token = tkn.clone();
				if( output.capture )
				{
					results.push( output );
					beginToken( output );
				}else 
				{
					dispose( output );
				}
				//switch off capture for once tokens
				if( tkn.once )
				{
					tkn.capture = false;
				}
				return output;
			//handles merging adjacent tokens with the same id
			}else {
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