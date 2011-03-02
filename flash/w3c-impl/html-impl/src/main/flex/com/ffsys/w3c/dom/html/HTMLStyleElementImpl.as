package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.css.LinkStyle;
	import org.w3c.dom.css.StyleSheet;
	
	import org.w3c.dom.html.HTMLStyleElement;
	
	/**
	* 	Represents the <code>style</code> element.
	*/
	public class HTMLStyleElementImpl extends HTMLElementImpl
		implements HTMLStyleElement, LinkStyle
	{
		private var _sheet:StyleSheet;
		
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "style";
		
		/**
		* 	Creates an <code>HTMLStyleElementImpl</code> instance.
		*/
		public function HTMLStyleElementImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get sheet():StyleSheet
		{
			return _sheet;
		}
	}
}