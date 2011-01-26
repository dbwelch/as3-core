package com.ffsys.token
{
	
	/**
	* 	//
	*/
	public class Token extends Object
	{
		/**
		* 	A regular expression indicating
		* 	the start of this token.
		*/	
		public var start:RegExp;
		
		/**
		* 	A regular expression indicating
		* 	the end of this token.
		*/
		public var end:RegExp;
		
		/**
		* 	Indicates whether this token is considered
		* 	to be open, ie, an end match has not yet
		* 	been found for the token.
		*/
		public var open:Boolean;
		
		/**
		* 	A regular expression or string indicating
		* 	that this token must be an entire
		* 	match.
		* 
		* 	When this property is specified
		* 	the start and end expressions are ignored
		* 	and this token is treated as a single complete
		* 	match.
		*/
		public var match:Object;
		
		/**
		* 	An identifier that can be assigned to
		* 	this token to indicate a token type.
		*/
		public var id:int;
		
		/**
		* 	The entire matched text for the token.
		*/
		public var matched:String;
		
		private var _alternatives:Vector.<Token>;
		private var _combinations:Vector.<Object>;
		
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
		* 	Alternative tokens that can be used
		* 	as comparison when performing complete
		* 	matching.
		*/
		public function get alternatives():Vector.<Token>
		{
			if( _alternatives == null )
			{
				_alternatives = new Vector.<Token>();
			}
			return _alternatives;
		}
		
		public function set alternatives( value:Vector.<Token> ):void
		{
			_alternatives = value;
		}
		
		/**
		* 	Combinations that must match
		* 	sequentially on the token.
		* 
		* 	A combination can be a string literal,
		* 	regular expression or another token
		* 	to use for comparison.
		*/
		public function get combinations():Vector.<Object>
		{
			if( _combinations == null )
			{
				_combinations = new Vector.<Object>();
			}
			return _combinations;
		}
		
		public function set combinations( value:Vector.<Object> ):void
		{
			_combinations = value;
		}
		
		/**
		* 	Determines whether this token
		* 	is an entire match.
		*/
		public function isMatch():Boolean
		{
			return match != null || alternatives.length > 0;
		}
		
		public function compare( candidate:String ):Boolean
		{
			var matches:Boolean = test( candidate );
			if( matches )
			{
				if( match is String )
				{
					matched = match as String;
				}else if( match is RegExp )
				{
					var results:Array = ( match as RegExp ).exec( candidate );
					
					matched = "";
					for( var i:int = 1;i < 2;i++ )
					{
						if( results[ i ] is String )
						{
							matched += results[ i ];
						}
					}
					
					//trace("Token::compare()", "GOT MATCHED", matched );
				}
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
		public function test( candidate:String ):Boolean
		{
			if( candidate != null )
			{
				if( start is RegExp )
				{
					//trace("Token::test()", "[FOUND START REGEXP]", start );
				}
				
				if( start is RegExp && start.test( candidate ) ) 
				{
					//trace("Token::test()", "[OPENING TOKEN]", this );
					open = true;
				}
				
				if( end is RegExp && end.test( candidate ) ) 
				{
					open = false;
				}
				
				var tkn:Token = null;
				if( isMatch() )
				{
					if( match is RegExp
						&& match.test( candidate ) )
					{
						return true;
					}else if( match is String && match == candidate )
					{
						return true;
					}
					
					if( alternatives.length > 0 )
					{
						for each( tkn in alternatives )
						{
							if( tkn.test( candidate ) )
							{
								return true;
							}
						}
					}
				}
				
				if( combinations.length > 0 )
				{
					var combo:Object = null;
					for each( combo in combinations )
					{
						//trace("Token::test()", "MATCHING COMBINATION: ", combo );
						if( combo is String )
						{
							var index:int = candidate.indexOf( combo as String );
							
							if( index != 0 )
							{
								return false;
							}else{
								//strip the matched string
								candidate =
									candidate.substr( ( combo as String ).length );
							}
						}
						
						if( combo is RegExp
							&& !( combo as RegExp ).test( candidate ) )
						{
							return false;
						}
						
						if( combo is Token
							&& ( combo as Token ).test( candidate ) === false )
						{
							return false;
						}
					}
					
					return true;
				}
				
				//trace("Token::test()", this, candidate );
			}
			return false;
		}
		
		/**
		* 	Creates a clone of this token.
		* 
		* 	@return A clone of this token.
		*/
		public function clone():Token
		{
			var output:Token = new Token( id, match );
			output.start = start;
			output.end = end;
			output.alternatives = alternatives.slice();			
			output.combinations = combinations.slice();	
			output.open = this.open;
			output.matched = matched;
			return output;
		}
		
		public function toString():String
		{
			return "[object Token(" + id + ")[" + match + "][" + matched + "]]";
		}
	}
}