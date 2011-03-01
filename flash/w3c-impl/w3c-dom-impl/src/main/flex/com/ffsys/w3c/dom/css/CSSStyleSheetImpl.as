package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Node;
	import org.w3c.dom.Element;
	
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSRuleList;
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.StyleSheet;
	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.DocumentCSS;
	import org.w3c.dom.css.StyleSheetList;	
		
	/**
	* 	Represents a CSS style sheet.
	*/
	public class CSSStyleSheetImpl extends StyleSheetImpl
		implements CSSStyleSheet, DocumentCSS
	{
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
		public function get styleSheets():StyleSheetList
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getOverrideStyle(
			element:Element, pseudo:String = null ):CSSStyleDeclaration
		{
			//TODO
			return null;
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
		public function get ownerRule():CSSRule
		{
			return _ownerRule;
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