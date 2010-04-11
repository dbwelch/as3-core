package com.ffsys.utils.string {
	
	/**
	*	Encapsulates commonly used <code>String</code>
	*	values as constants.
	*	
	*	@see com.ffsys.utils.string.StringFormatter
	*	@see com.ffsys.utils.string.StringHelper
	*	@see com.ffsys.utils.string.StringPad
	*	@see com.ffsys.utils.string.StringRepeater
	*	@see com.ffsys.utils.string.StringStrip
	*	@see com.ffsys.utils.string.StringSubstitutor
	*	@see com.ffsys.utils.string.StringTrim
	*	@see com.ffsys.utils.string.StringUtils
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class StringConstants extends Object {
		
		/**
		*	Constant representing the escape character.	
		*/
		static public const ESCAPE:String = "\\";
		
		/**
		*	Constant representing the delimiter in a URI.
		*/
		static public const URI_DELIMITER:String = "/";
		
		/**
		*	Constant for a newline character.
		*/
		static public const NEWLINE:String = "\n";
		
		/**
		*	Constant for a tab character.
		*/
		static public const TAB:String = "\t";
		
		/**
		*	Constant for a hyphen character.
		*/
		static public const HYPHEN:String = "-";
		
		/**
		*	Constant for an underscore character.
		*/
		static public const UNDERSCORE:String = "_";
		
		static public const HASH:String = "#";
		
		static public const ASTERISK:String = "*";
				
		static public const SPACE:String = " ";
		
		static public const DOT:String = ".";
		
		static public const COMMA:String = ",";
		
		static public const LEFT_BRACE:String = "{";
		static public const RIGHT_BRACE:String = "}";
		
		static public const INDENT:String = "  ";
		
		/**
		*	@private	
		*/
		public function StringConstants()
		{
			super();
		}		
	}
}