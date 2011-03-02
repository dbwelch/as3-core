package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Node;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.DOMFeature;
	import org.w3c.dom.Element;	
	
	import org.w3c.dom.css.CSSCharsetRule;
	import org.w3c.dom.css.CSSImportRule;
	import org.w3c.dom.css.CSSMediaRule;
	import org.w3c.dom.css.CSSFontFaceRule;
	import org.w3c.dom.css.CSSPageRule;
	import org.w3c.dom.css.CSSStyleRule;
	import org.w3c.dom.css.CSSUnknownRule;
	
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSRuleList;
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.RuleType;	
	import org.w3c.dom.css.StyleSheet;
	import org.w3c.dom.css.DocumentCSS;
	import org.w3c.dom.css.StyleSheetList;
			
	/**
	* 	Represents a CSS style sheet.
	*/
	public class CSSStyleSheetImpl extends StyleSheetImpl
		implements CSSStyleSheet, DocumentCSS
	{
		/**
		* 	The bean name for the implementation of the
		* 	"StyleSheets", "CSS" and "CSS2" features.
		*/
		public static const NAME:String = DOMFeature.CSS_MODULE;
		
		private var _styleSheets:StyleSheetList;
		private var _cssRules:CSSRuleList;
		private var _ownerRule:CSSRule;
				
		/**
		* 	Creates a <code>CSSStyleSheetImpl</code> instance.
		* 
		* 	@param parent A parent style sheet implementation.
		* 	@param owner The node that owns this style sheet.
		*/
		public function CSSStyleSheetImpl(
			parent:StyleSheet = null,
			owner:Node = null )
		{
			super( parent, owner );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get documentElement():Element
		{
			if( _documentElement == null )
			{
				//create a top-level document element when needed
				_documentElement = createElement(
					CSSDocumentElementImpl.NAME );
			}
			return _documentElement;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleSheets():StyleSheetList
		{
			if( _styleSheets == null )
			{
				//initial list just contains this stylesheet
				_styleSheets = new StyleSheetListImpl();
				_styleSheets[ 0 ] = this;
			}
			return _styleSheets;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getOverrideStyle(
			element:Element, pseudo:String = null ):CSSStyleDeclaration
		{
			return null;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get cssRules():CSSRuleList
		{
			if( _cssRules == null )
			{
				_cssRules = new CSSRuleListImpl();
			}
			return _cssRules;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get ownerRule():CSSRule
		{
			return _ownerRule;
		}
	
		/**
		* 	@inheritDoc
		*/
		
		/*
		
		* 	@throws DOMException.HIERARCHY_REQUEST_ERR: Raised if the rule cannot
		* 	be inserted at the specified index, e.g., if an @import rule is inserted
		* 	after a standard rule set or other at-rule.
		*	@throws DOMException.INDEX_SIZE_ERR: Raised if the specified index is
		* 	not a valid insertion point.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if this style
		* 	sheet is readonly.
		*	@throws DOMException.SYNTAX_ERR: Raised if the specified rule has a
		* 	syntax error and is unparsable.		
		
		*/
		public function insertRule( rule:String, index:uint ):uint
		{			
			return 0;
		}
	
		/**
		* 	@inheritDoc
		*/
		public function deleteRule( index:uint ):void
		{
			//TODO
		}
		
		/**
		* 	Creates a <code>CSSRule</code> instance.
		* 
		* 	@param type The type of rule to create.
		* 
		* 	@throws DOMException.TYPE_MISMATCH_ERR: 
		* 	If the specified type is not a valid CSS
		* 	rule type identifier.
		* 
		* 	@return A CSS rule of the specified type.
		*/
		public function createCSSRule( type:uint ):CSSRule
		{
			if( !RuleType.isValid( type ) )
			{
				throw new DOMException(
					DOMException.INVALID_CSS_RULE_TYPE,
					null,
					DOMException.TYPE_MISMATCH_ERR,
					[ type ] );
			}
			
			var rule:CSSRuleImpl = null;
			rule = CSSRuleImpl( getDomBean(
				__cssRuleImplementations[ type ] ) );
			rule.setParentStyleSheet( this );
			return rule;
		}
		
		/**
		* 	Creates a charset at-rule.
		* 
		* 	@param encoding The encoding for the character
		* 	set rule.
		* 
		* 	@return A charset rule implementation.
		*/
		public function createCharsetRule( encoding:String ):CSSCharsetRule
		{
			var rule:CSSCharsetRuleImpl = CSSCharsetRuleImpl(
				createCSSRule( RuleType.CHARSET_RULE ) );
			rule.encoding = encoding;
			return rule;
		}
		
		/**
		* 	Creates an import at-rule.
		* 
		* 	@param href The URI for the document to import.
		* 	@param media A comma-delimited list of mediums.
		* 
		* 	@return An import rule implementation.
		*/
		public function createImportRule( href:String, media:String = null ):CSSImportRule
		{
			var rule:CSSImportRuleImpl = CSSImportRuleImpl(
				createCSSRule( RuleType.IMPORT_RULE ) );
			rule.setHref( href );
			
			//rule.parseMedia( media );
			
			return rule;
		}
		
		/**
		* 	Creates a media at-rule.
		*
		* 	@param media A comma-delimited list of mediums.
		* 
		* 	@return A media rule implementation.
		*/
		public function createMediaRule( media:String = null ):CSSMediaRule
		{
			var rule:CSSMediaRuleImpl = CSSMediaRuleImpl(
				createCSSRule( RuleType.MEDIA_RULE ) );

			//rule.parseMedia( media );
			return rule;
		}
		
		/**
		* 	Creates a font-face at-rule.
		*
		* 	@param style A style declaration for the rule.
		* 
		* 	@return A font-face rule implementation.
		*/
		public function createFontFaceRule( style:CSSStyleDeclaration = null ):CSSFontFaceRule
		{
			var rule:CSSFontFaceRuleImpl = CSSFontFaceRuleImpl(
				createCSSRule( RuleType.FONT_FACE_RULE ) );
			//TOOD: set the declaration where necessary
			return rule;
		}
		
		/**
		* 	Creates a page at-rule.
		*
		* 	@param selectorText The CSS text for the page rule selector
		* 	and declaration.
		* 
		* 	@return A page rule implementation.
		*/
		public function createPageRule( selectorText:String = null ):CSSPageRule
		{
			var rule:CSSPageRuleImpl = CSSPageRuleImpl(
				createCSSRule( RuleType.PAGE_RULE ) );
			//TOOD: set the selectorText where necessary
			return rule;	
		}
		
		/**
		* 	Creates a style at-rule.
		*
		* 	@param selectorText The CSS text for the style rule selector
		* 	and declaration.
		* 
		* 	@return A style rule implementation.
		*/
		public function createStyleRule( selectorText:String = null ):CSSStyleRule
		{
			var rule:CSSStyleRuleImpl = CSSStyleRuleImpl(
				createCSSRule( RuleType.STYLE_RULE ) );
			//TOOD: set the selectorText where necessary
			return rule;
		}	
		
		/**
		* 	Creates an unknown at-rule.
		*
		* 	@param cssText The CSS text for the entire rule declaration
		* 	including the at-rule.
		* 
		* 	@return An unknown rule implementation.
		*/
		public function createUnknownRule( cssText:String = null ):CSSUnknownRule
		{
			var rule:CSSUnknownRuleImpl = CSSUnknownRuleImpl(
				createCSSRule( RuleType.UNKNOWN_RULE ) );
			//TOOD: set the cssText where necessary
			return rule;
		}
		
		/**
		* 	@private
		* 
		* 	Provides a mapping between CSS rule type unsigned
		* 	integers and the bean names for the corresponding
		* 	implementations.
		* 
		* 	Declaration order is important as it is the index
		* 	that matches the type unsigned integer.
		*/
		private static var __cssRuleImplementations:Array
			= [
				CSSUnknownRuleImpl.NAME,
				CSSStyleRuleImpl.NAME,
				CSSCharsetRuleImpl.NAME,
				CSSImportRuleImpl.NAME,
				CSSMediaRuleImpl.NAME,
				CSSFontFaceRuleImpl.NAME,
				CSSPageRuleImpl.NAME
			];
	}
}