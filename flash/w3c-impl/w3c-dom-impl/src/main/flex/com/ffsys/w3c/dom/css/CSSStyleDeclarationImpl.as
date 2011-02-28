package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.CSSValue;
	
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	Represents a CSS style declaration.
	*/
	public class CSSStyleDeclarationImpl extends ElementImpl
		implements CSSStyleDeclaration
	{
		private var _cssText:String;
		private var _parentRule:CSSRule;
		
		/**
		* 	Creates a <code>CSSStyleDeclarationImpl</code> instance.
		* 
		* 	@param parent A parent rule for this declaration.
		*/
		public function CSSStyleDeclarationImpl(
			parent:CSSRule = null )
		{
			super();
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