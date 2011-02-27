package com.ffsys.w3c.dom.css
{	
	import org.w3c.dom.css.CSSPageRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;
	
	/**
	*	 Represents a &#64;page CSS rule.
	*/
	public class CSSPageRuleImpl extends CSSRuleImpl
		implements CSSPageRule
	{
		private var _style:CSSStyleDeclaration;
		private var _selectorText:String;
		
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