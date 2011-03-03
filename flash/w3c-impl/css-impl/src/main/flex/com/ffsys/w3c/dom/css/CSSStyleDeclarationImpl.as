package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSStyleSheet;	
	import org.w3c.dom.css.CSSValue;
	
	import com.ffsys.w3c.dom.CoreDocumentImpl;	
	import com.ffsys.w3c.dom.ElementImpl;
	
	import com.ffsys.w3c.dom.css.support.CSSInterpreter;
	
	
	/**
	* 	Represents a CSS style declaration.
	*/
	public class CSSStyleDeclarationImpl extends ElementImpl
		implements CSSStyleDeclaration
	{
		/**
		* 	The bean name for a style declaration implementation.
		*/
		public static const NAME:String = "decl";
		
		private var _cssText:String;
		private var _parentRule:CSSRule;
		
		/**
		* 	Creates a <code>CSSStyleDeclarationImpl</code> instance.
		* 
		* 	@param parent A parent rule for this declaration.
		*/
		public function CSSStyleDeclarationImpl(
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
		public function get cssText():String
		{
			return _cssText;
		}
		
		public function set cssText( text:String ):void
		{
			trace("CSSStyleDeclarationImpl::set cssText()", text, ownerDocument );
			
			var interpreter:CSSInterpreter = CSSInterpreter.newInstance(
				CSSStyleSheetImpl( ownerDocument ) );
				
			var result:Object = interpreter.interpret( text );
			
			trace("[GOT INTERPRETER RESULT] CSSStyleDeclarationImpl::set cssText()",
				result );
				
			_cssText = text;				
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
		public function item( index:uint ):String
		{
			var n:Node = childNodes.item( index );
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getPropertyCSSValue(
			propertyName:String ):CSSValue
		{
			//TODO
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function getPropertyPriority(
			propertyName:String ):String
		{
			//TODO
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function getPropertyValue(
			propertyName:String ):String
		{
			//TODO
			return null;			
		}
			
		/**
		* 	@inheritDoc
		*/
		public function removeProperty(
			propertyName:String ):String
		{
			//TODO
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function setProperty(
			propertyName:String,
			value:String,
			priority:String = "" ):void
		{
			//TODO
		}		
	}
}