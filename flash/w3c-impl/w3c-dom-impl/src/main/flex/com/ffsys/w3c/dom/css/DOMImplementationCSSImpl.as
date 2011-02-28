package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	
	/**
	* 	Represents a CSS DOM implementation.
	*/
	public class DOMImplementationCSSImpl extends DOMImplementationLSImpl
		implements DOMImplementationCSS
	{
		/**
		* 	The bean name for the implementation of the "HTML" feature.
		*/
		public static const NAME:String = "dom-css-impl";
		
		/**
		* 	Creates a <code>DOMImplementationCSSImpl</code> instance.
		*/
		public function DOMImplementationCSSImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createCSSStyleSheet(
			title:String, media:String ):CSSStyleSheet
		{
			//TODO
			return null;
		}
	}
}