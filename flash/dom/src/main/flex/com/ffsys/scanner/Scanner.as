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
			configure();			
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
		*/
		public function get tokens():Vector.<Token>
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
		private function scanSource():void
		{
			if( source != null )
			{
				var i:int = 0;
				var c:String = null;
				var tkn:Token = null;
				
				//trace("Scanner::scanSource()", "[TESTING SOURCE]", "'" + source + "'" );
				
				_lastMatch = null;

				tkn = matchTokens( source, _current );
				
				//TODO
				
				//set current token first time around
				if( ( tkn != null && _current == null ) )
				{
					_current = tkn;
				}else if(
					tkn != null
				 	&& _current != null
				 	&& tkn.id != _current.id )
				{
					_current = tkn
				}				
				
				if( _lastMatch != null
					&& _lastMatch.length > 0
					&& source.length > 0 )
				{
					_source = chomp();	
					//scan any remaining source
					scanSource();
				}
			}
		}
		
		/**
		* 	@private
		*/
		protected function chomp():String
		{
			//chomp the matched value				
			var output:String = source.substr( _lastMatch.length );
			_lastMatch = null;
			return output;
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
		* 	@private
		*/
		protected function handleMatchedToken(
			tkn:Token, current:Token = null, candidate:String = null ):Token
		{
			//get a new token to store as result from
			//a clone of the matched token				
			if( current == null
				|| tkn.id != current.id )
			{
				var output:Token = tkn.clone();
				//trace("[CREATED TOKEN] Scanner::scanSource() id:", output.id );
				results.push( output );
				return output;
			//handles merging adjacent tokens with the same id
			}else {
				current.matched += _lastMatch;
				return current;
			}
			return tkn;
		}
		
		/**
		* 	@private
		*/
		protected function matchTokens(
			candidate:String,
			current:Token = null ):Token
		{
			if( candidate != null )
			{
				//trace("Scanner::testTokens()", current );
				var tkn:Token = null;
				for each( tkn in tokens )
				{
					if( compare( tkn, candidate ) )
					{
						return handleMatchedToken( tkn, current );
					}			
				}
			}
			return null;
		}
	}
}