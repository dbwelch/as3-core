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
	public class Tokenizer extends Object
	{
		private var _tokens:Vector.<Token>;
		private var _results:Vector.<Token>;
		
		
		private var _lastMatch:String;
		private var _ctkn:Token = null;		
		
		/**
		* 	Creates a <code>Tokenizer</code> instance.
		*/
		public function Tokenizer()
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
			parseSource( source );
			return _results;
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
		private function parseSource( source:String ):void
		{
			if( source != null )
			{
				var i:int = 0;
				var c:String = null;
				var current:String = null;
				var tkn:Token = null;
				
				//trace("Tokenizer::parseSource()", "[TESTING SOURCE]", "'" + source + "'" );
				
				_lastMatch = null;
				
				tkn = matchTokens( source, _ctkn );
				
				if( _lastMatch != null
					&& _lastMatch.length > 0
					&& source.length > 0 )
				{
					
					//trace("Tokenizer::parseSource()", "[AFTER MATCH]", _lastMatch );					
					source = source.substr( _lastMatch.length );
					parseSource( source );
					
					if( tkn != null
						&& _ctkn != null
						&& tkn.id != _ctkn.id )
					{
						_ctkn = tkn;
					}
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function matchTokens(
			candidate:String,
			current:Token = null ):Token
		{
			if( candidate != null )
			{
				//trace("Tokenizer::testTokens()", candidate );
				var output:Token = null;
				var tkn:Token = null;
				for each( tkn in tokens )
				{
					if( tkn.compare( candidate ) )
					{
						_lastMatch = tkn.matched;						
						if( current == null || tkn.id != current.id )
						{
							output = tkn.clone();
							results.push( output );
							return output;
						}else{
							current.matched += _lastMatch;
							return current;
						}
					}
				}
			}
			return null;
		}
	}
}