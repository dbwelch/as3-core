package com.ffsys.utils.regex {
	
	/**
	*	Utility methods for working with regular expressions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class RegexUtils extends Object {
		
		/**
		*	Constant representing the backslash escape character.
		*/
		static public const ESCAPE_CHARACTER:String = "\\";
		
		/**
		*	List of regular expression meta characters.
		*/
		static public const META_CHARACTERS:Array = [
			"{",
			"}",
			"(",
			")",
			"[",
			"]",
			"^",
			"$",
			".",
			"?",
			"+"
		];
		
		/**
		*	@private
		*/
		public function RegexUtils()
		{
			super();
		}
		
		/**
		*	Given a <code>source</code> this method will escape any
		*	<code>RegExp</code> meta characters with a backslash.
		*	
		*	This allows a <code>RegExp</code> to use tainted strings
		*	(possibly supplied from user input) as part of a match
		*	yet maintain the original pattern. Any <code>RegExp</code>
		*	meta characters within the escaped <code>String</code> are
		*	then treated as literal <code>String</code> values rather than
		*	<code>RegExp</code> meta characters.
		*
		*	@param source The <code>source</code> to escape.
		*
		*	@return A <code>String</code> with any
		*	regular expression meta characters escaped.
		*/
		static public function escape( source:String ):String
		{
			var output:String = source;
			
			var i:int = 0;
			var l:int = META_CHARACTERS.length;
			
			var re:RegExp;
			
			var char:String;
			var index:int;
			
			for( ;i < l;i++ )
			{
				char = META_CHARACTERS[ i ];
				
				re = new RegExp( ESCAPE_CHARACTER + char, "g" );
				output = output.replace( re, ESCAPE_CHARACTER + char );
			}
			
			return output;
		}
	}
}