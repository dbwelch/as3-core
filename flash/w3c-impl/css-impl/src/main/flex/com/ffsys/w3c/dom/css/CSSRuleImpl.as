package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSStyleSheet;
	
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	Abstract super class for CSS rules.
	*/
	public class CSSRuleImpl extends ElementImpl
		implements CSSRule
	{		
		/**
		* 	@private
		* 	
		* 	Stores the type of this rule.
		*/
		protected var __cssRuleType:uint;
		
		private var _cssText:String;
		private var _parentStyleSheet:CSSStyleSheet;
		private var _parentRule:CSSRule;
		
		/**
		* 	Creates a <code>CSSRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null )
		{
			super();
			_parentStyleSheet = sheet;
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
			return _parentStyleSheet;
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