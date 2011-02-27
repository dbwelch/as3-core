package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	
	/**
	* 	Abstract super class for CSS rules.
	*/
	public class CSSRuleImpl extends AbstractCSSDOMElement
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
		* 	@private
		* 	
		* 	Stores the type of this rule.
		*/
		protected var __cssRuleType:uint;
		
		private var _cssText:String;
		private var _parentStyleSheet:CSSStyleSheet;
		private var _parentRule:CSSRule;
		
		/**
		* 	Creates a <code>CSSRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			super();
			_parentStyleSheet = sheet;
			_parentRule = parent;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get type():uint
		{
			return __cssRuleType;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get cssText():String
		{
			return _cssText;
		}
		
		public function set cssText( text:String ):void
		{
			_cssText = text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parentStyleSheet():CSSStyleSheet
		{
			return _parentStyleSheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parentRule():CSSRule
		{
			return _parentRule;
		}	
	}
}