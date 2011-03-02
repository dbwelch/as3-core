package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Document;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	
	import com.ffsys.w3c.dom.ElementImpl;
	import com.ffsys.w3c.dom.CoreDocumentImpl;	
	
	/**
	* 	Abstract super class for CSS rules.
	*/
	public class CSSRuleImpl extends ElementImpl
		implements CSSRule
	{		
		/**
		* 	The bean name for CSS rule implementations.
		*/
		public static const NAME:String = "at-rule";
		
		/**
		* 	@private
		* 	
		* 	Stores the type of this rule.
		*/
		protected var __cssRuleType:uint;
		
		private var _cssText:String;
		private var _parentRule:CSSRule;
		
		/**
		* 	Creates a <code>CSSRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			super( CoreDocumentImpl( sheet ), name );
			_parentRule = parent;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get type():uint
		{
			return __cssRuleType;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get cssText():String
		{
			return _cssText;
		}
		
		public function set cssText( text:String ):void
		{
			_cssText = text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parentStyleSheet():CSSStyleSheet
		{
			return ownerDocument as CSSStyleSheet;
		}
		
		/**
		* 	@private
		*/
		internal function setParentStyleSheet( parent:CSSStyleSheet ):void
		{
			_ownerDocument = Document( parent );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parentRule():CSSRule
		{
			return _parentRule;
		}	
	}
}