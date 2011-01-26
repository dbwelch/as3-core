package com.ffsys.token
{
	
	/**
	*	Responsible for tokenizing text.
	* 
	* 	Derived implementations may define
	* 	the default tokens in the
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
		protected var _ctkn:Token = null;
		
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
		* 	the default tokens for this tokenizer.
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
		public function parse( source:String ):Vector.<Token>
		{
			_ctkn = null;
			_source = source;
			parseSource();
			//clean up
			cleanup();
			return _results;
		}
		
		/**
		* 	The source currently being scanned.
		* 
		* 	Note this may not match the source
		* 	specified when the <code>parse</code>
		* 	method was invoked as the source is
		* 	modified during the scan.
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
			_ctkn = null;
		}
		
		/**
		* 	A list of tokens that represent the parsed
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
		* 	The list of tokens for this tokenizer.
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
		private function parseSource():void
		{
			if( source != null )
			{
				var i:int = 0;
				var c:String = null;
				var tkn:Token = null;
				
				//trace("Scanner::parseSource()", "[TESTING SOURCE]", "'" + source + "'" );
				
				_lastMatch = null;

				tkn = matchTokens( source, _ctkn );
				
				//TODO
				
				//set current token first time around
				if( ( tkn != null && _ctkn == null ) )
				{
					_ctkn = tkn;
				}else if(
					tkn != null
				 	&& _ctkn != null
				 	&& tkn.id != _ctkn.id )
				{
					_ctkn = tkn
				}				
				
				if( _lastMatch != null
					&& _lastMatch.length > 0
					&& source.length > 0 )
				{
					//source = chomp( source );
					
					_source = chomp();
					
					//parse any remaining source
					parseSource();
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
				//trace("[CREATED TOKEN] Scanner::parseSource() id:", output.id );
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