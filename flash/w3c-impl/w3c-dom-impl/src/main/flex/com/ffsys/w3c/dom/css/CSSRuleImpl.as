package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSRule;
	
	/**
	* 	
	*/
	public class CSSRuleImpl extends Object
		implements CSSRule
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
		* 	Creates a <code>CSSRuleImpl</code> instance.
		*/
		public function CSSRuleImpl()
		{
			super();
		}
	}
}