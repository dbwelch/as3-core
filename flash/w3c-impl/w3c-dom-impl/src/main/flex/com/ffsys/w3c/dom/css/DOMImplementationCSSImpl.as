package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	
	/**
	* 	Represents a CSS DOM implementation.
	*/
	public class DOMImplementationCSSImpl extends DOMImplementationImpl
		implements DOMImplementationCSS
	{
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