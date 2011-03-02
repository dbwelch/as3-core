package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSStyleRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;	
	import org.w3c.dom.css.RuleType;
	
	/**
	* 	Represents a single rule set in a CSS style sheet.
	*/
	public class CSSStyleRuleImpl extends CSSRuleImpl
		implements CSSStyleRule
	{
		private var _style:CSSStyleDeclaration;
		private var _selectorText:String;
				
		/**
		* 	Creates a <code>CSSStyleRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSStyleRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			__cssRuleType = RuleType.STYLE_RULE;
			super( sheet, parent );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get style():CSSStyleDeclaration
		{
			return _style;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get selectorText():String
		{
			return _selectorText;
		}
		
		public function set selectorText( text:String ):void
		{
			_selectorText = text;
		}		
	}
}