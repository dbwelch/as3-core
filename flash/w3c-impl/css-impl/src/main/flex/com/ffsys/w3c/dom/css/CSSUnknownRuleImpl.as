package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSUnknownRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.RuleType;	
	
	/**
	* 	Represents an unknown at-rule.
	*/
	public class CSSUnknownRuleImpl extends CSSRuleImpl
		implements CSSUnknownRule
	{		
		/**
		* 	The bean name for an unknown at-rule.
		*/
		public static const NAME:String = "unknown";
		
		/**
		* 	Creates a <code>CSSUnknownRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSUnknownRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.UNKNOWN_RULE;
			super( sheet, parent );
		}
	}
}