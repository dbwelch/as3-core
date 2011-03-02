package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSImportRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.MediaList;
	import org.w3c.dom.css.RuleType;	
	
	/**
	*	 Represents an &#64;import CSS rule.
	*/
	public class CSSImportRuleImpl extends CSSRuleImpl
		implements CSSImportRule
	{
		/**
		* 	The bean name for an import at-rule.
		*/
		public static const NAME:String = "import";
		
		/**
		* 	The name of the <code>href</code> attribute.
		*/
		public static const HREF_ATTR:String = "href";
		
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
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.IMPORT_RULE;
			super( sheet, parent, name );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get href():String
		{
			return getAttribute( HREF_ATTR );
		}
		
		/**
		* 	@private
		*/
		internal function setHref( value:String ):void
		{
			setAttribute( HREF_ATTR, value );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get media():MediaList
		{
			return _media;
		}
		
		/**
		* 	@private
		*/
		internal function parseMedia( value:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleSheet():CSSStyleSheet
		{
			return _styleSheet;
		}
		
		/**
		* 	@private
		*/
		internal function setStyleSheet( sheet:CSSStyleSheet ):void
		{
			_styleSheet = sheet;
		}
	}
}