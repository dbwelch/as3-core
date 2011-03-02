package com.ffsys.w3c.dom.css
{	
	import org.w3c.dom.css.CSSPageRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.RuleType;	
	
	/**
	*	 Represents a &#64;page CSS rule.
	*/
	public class CSSPageRuleImpl extends CSSStyleRuleImpl
		implements CSSPageRule
	{		
		/**
		* 	The bean name for a page at-rule.
		*/
		public static const NAME:String = "page";
		
		/**
		* 	Creates a <code>CSSPageRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSPageRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.PAGE_RULE;
			super( sheet, parent, name );
		}
	}
}