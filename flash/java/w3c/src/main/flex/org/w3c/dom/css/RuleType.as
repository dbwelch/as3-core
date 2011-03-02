package org.w3c.dom.css
{
	/**
	* 	Encapsulates the constants that represent CSS rule types.
	*/
	public class RuleType extends Object
	{
		/**
		* 	The rule is a CSSUnknownRule.
		*/
		public static const UNKNOWN_RULE:uint                   = 0;
		
		/**
		* 	The rule is a CSSStyleRule.
		*/
		public static const STYLE_RULE:uint                     = 1;
		
		/**
		* 	The rule is a CSSCharsetRule.
		*/
		public static const CHARSET_RULE:uint                   = 2;
		
		/**
		* 	The rule is a CSSImportRule.
		*/
		public static const IMPORT_RULE:uint                    = 3;
		
		/**
		* 	The rule is a CSSMediaRule.
		*/
		public static const MEDIA_RULE:uint                     = 4;
		
		/**
		* 	The rule is a CSSFontFaceRule.
		*/
		public static const FONT_FACE_RULE:uint                 = 5;
		
		/**
		* 	The rule is a CSSPageRule.
		*/
		public static const PAGE_RULE:uint                      = 6;	
		
		/**
		* 	Determines whether a candidate
		* 	rule type is value.
		* 
		* 	@param type The candidate rule type.
		* 
		* 	@return Whether the type is a recognised
		* 	rule type.
		*/
		static public function isValid( type:uint ):Boolean
		{
			return type === UNKNOWN_RULE
				|| type === STYLE_RULE
				|| type === CHARSET_RULE
				|| type === IMPORT_RULE
				|| type === MEDIA_RULE
				|| type === FONT_FACE_RULE
				|| type === PAGE_RULE;
		}	
	}
}