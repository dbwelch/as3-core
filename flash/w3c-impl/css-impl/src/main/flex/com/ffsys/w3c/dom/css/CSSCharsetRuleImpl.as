package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSCharsetRule;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.RuleType;
	
	/**
	*	 Represents a &#64;charset CSS rule.
	*/
	public class CSSCharsetRuleImpl extends CSSRuleImpl
		implements CSSCharsetRule
	{
		/**
		* 	The bean name for a charset at-rule.
		*/
		public static const NAME:String = "charset";
		
		/**
		* 	The name of the <code>encoding</code> attribute.
		*/
		public static const ENCODING_ATTR:String = "encoding";
		
		private var _encoding:String;		
		
		/**
		* 	Creates a <code>CSSCharsetRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSCharsetRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.CHARSET_RULE;
			super( sheet, parent, name );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get encoding():String
		{
			return getAttribute( ENCODING_ATTR );
		}
		
		public function set encoding( value:String ):void
		{
			setAttribute( ENCODING_ATTR, value )
		}
	}
}