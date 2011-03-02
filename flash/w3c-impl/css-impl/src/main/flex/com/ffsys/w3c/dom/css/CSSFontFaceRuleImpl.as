package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSFontFaceRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;	
	import org.w3c.dom.css.RuleType;	
	
	/**
	*	 Represents a &#64;font-face CSS rule.
	*/
	public class CSSFontFaceRuleImpl extends CSSRuleImpl
		implements CSSFontFaceRule
	{
		/**
		* 	The bean name for a font-face at-rule.
		*/
		public static const NAME:String = "font-face";
		
		private var _style:CSSStyleDeclaration;
		
		/**
		* 	Creates a <code>CSSFontFaceRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSFontFaceRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.FONT_FACE_RULE;
			super( sheet, parent, name );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get style():CSSStyleDeclaration
		{
			return _style;
		}
	}
}