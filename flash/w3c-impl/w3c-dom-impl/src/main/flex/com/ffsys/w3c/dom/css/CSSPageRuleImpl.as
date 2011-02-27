package com.ffsys.w3c.dom.css
{	
	import org.w3c.dom.css.CSSPageRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	
	/**
	*	 Represents a &#64;page CSS rule.
	*/
	public class CSSPageRuleImpl extends CSSStyleRuleImpl
		implements CSSPageRule
	{		
		/**
		* 	Creates a <code>CSSPageRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSPageRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			__cssRuleType = PAGE_RULE;
			super( sheet, parent );
		}
	}
}