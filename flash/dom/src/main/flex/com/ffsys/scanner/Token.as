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
		* 	Determines whether this token
		* 	is an entire match.
		*/
		public function isMatch():Boolean
		{
			return match != null;
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
					var results:Array = re.exec( candidate );
					if( results[ 1 ] is String )
					{
						matched = results[ 1 ];
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
		* 	@return A clone of this token.
		*/
		public function clone():Token
		{
			var output:Token = new Token( id, match );
			output.start = start;
			output.end = end;
			output.open = this.open;
			output.matched = matched;
			return output;
		}
		
		/**
		* 	Retrieves a string representation of this token.
		* 
		* 	@return A string representation of this token.
		*/
		public function toString():String
		{
			return "[object Token]["
				+ id + "] "
				+ ( /^\s+$/.test( matched ) ? "\\s+" : matched );
		}
	}
}