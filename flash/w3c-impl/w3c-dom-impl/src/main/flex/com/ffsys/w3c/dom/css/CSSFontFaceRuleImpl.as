package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSFontFaceRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;	
	
	/**
	*	 Represents a &#64;font-face CSS rule.
	*/
	public class CSSFontFaceRuleImpl extends CSSRuleImpl
		implements CSSFontFaceRule
	{
		private var _style:CSSStyleDeclaration;
		
		/**
		* 	Creates a <code>CSSFontFaceRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSFontFaceRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			__cssRuleType = FONT_FACE_RULE;
			super( sheet, parent );
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