package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Document;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSRuleList;	
	import org.w3c.dom.css.CSSStyleSheet;
	
	import com.ffsys.w3c.dom.CoreDocumentImpl;	
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	Abstract super class for CSS rules.
	* 
	* 	Note that the CSS specification does not explicitly
	* 	indicate that all rules may contain nested rules
	* 	(for example, the "charset" and "import" rules do not
	* 	contain child rules).
	* 
	* 	Regardless, this implementation is structured in a way
	* 	as to allow any rule to contain any number of child
	* 	rules.
	* 
	* 	Derived implementations may choose to restrict access
	* 	to the methods used to add child rules by throwing an
	* 	exception where appropriate.
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
		
		private var _cssRules:CSSRuleList;		
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
		
		/**
		* 	@inheritDoc
		*/
		public function get cssRules():CSSRuleList
		{
			//
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