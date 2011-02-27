package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSImportRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.MediaList;
	
	/**
	*	 Represents an &#64;import CSS rule.
	*/
	public class CSSImportRuleImpl extends CSSRuleImpl
		implements CSSImportRule
	{
		private var _href:String;
		private var _media:MediaList;
		private var _styleSheet:CSSStyleSheet;
		
		/**
		* 	Creates a <code>CSSImportRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSImportRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			__cssRuleType = IMPORT_RULE;
			super( sheet, parent );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get href():String
		{
			return _href;
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
		public function get styleSheet():CSSStyleSheet
		{
			return _styleSheet;
		}
	}
}