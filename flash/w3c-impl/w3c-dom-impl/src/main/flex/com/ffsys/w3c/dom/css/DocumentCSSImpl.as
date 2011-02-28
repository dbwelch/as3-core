package com.ffsys.w3c.dom.css
{
	import com.ffsys.w3c.dom.DocumentImpl;
	
	import org.w3c.dom.Element;
	
	import org.w3c.dom.css.CSSStyleDeclaration;
	import org.w3c.dom.css.DocumentCSS;
	import org.w3c.dom.css.StyleSheetList;
	
	/**
	* 	Represents a CSS document.
	*/
	public class DocumentCSSImpl extends DocumentImpl
		implements DocumentCSS
	{
		/**
		* 	Creates a <code>DocumentCSSImpl</code> instance.
		*/
		public function DocumentCSSImpl()
		{
			super();
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
	}
}