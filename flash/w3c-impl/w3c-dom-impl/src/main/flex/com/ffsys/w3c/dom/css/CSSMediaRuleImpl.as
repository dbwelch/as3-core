package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSMediaRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSRuleList;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.MediaList;
	import org.w3c.dom.css.RuleType;	
	
	/**
	*	 Represents a &#64;media CSS rule.
	*/
	public class CSSMediaRuleImpl extends CSSRuleImpl
		implements CSSMediaRule
	{
		private var _media:MediaList;
		private var _cssRules:CSSRuleList;
		
		/**
		* 	Creates a <code>CSSMediaRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSMediaRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			__cssRuleType = RuleType.MEDIA_RULE;
			super( sheet, parent );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get media():MediaList
		{
			return _media;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get cssRules():CSSRuleList
		{
			return _cssRules;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function insertRule( rule:String, index:uint ):uint
		{
			//TODO
			return 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function deleteRule( index:uint ):void
		{
			//TODO
		}
	}
}