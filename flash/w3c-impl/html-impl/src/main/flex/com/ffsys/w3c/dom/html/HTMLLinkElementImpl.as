package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.css.LinkStyle;
	import org.w3c.dom.css.StyleSheet;
	
	import org.w3c.dom.html.HTMLLinkElement;
	
	/**
	* 	Represents the <code>link</code> element.
	*/
	public class HTMLLinkElementImpl extends HTMLElementImpl
		implements HTMLLinkElement, LinkStyle
	{
		private var _sheet:StyleSheet;
		
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "link";
		
		/**
		* 	Creates an <code>HTMLLinkElementImpl</code> instance.
		*/
		public function HTMLLinkElementImpl()
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