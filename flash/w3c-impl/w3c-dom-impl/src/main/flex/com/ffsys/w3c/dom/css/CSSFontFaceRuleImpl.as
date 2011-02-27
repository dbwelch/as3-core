package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSFontFaceRule;
	import org.w3c.dom.css.CSSStyleDeclaration;
	
	/**
	*	 Represents a &#64;font-face CSS rule.
	*/
	public class CSSFontFaceRuleImpl extends CSSRuleImpl
		implements CSSFontFaceRule
	{
		private var _style:CSSStyleDeclaration;
		
		/**
		* 	Creates a <code>CSSFontFaceRuleImpl</code> instance.
		*/
		public function CSSFontFaceRuleImpl()
		{
			__cssRuleType = FONT_FACE_RULE;
			super();
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