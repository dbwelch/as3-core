package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLHtmlElement;
	
	/**
	* 	The main top-level <code>html</code> element
	* 	for a HTML document.
	*/
	public class HTMLHtmlElementImpl extends HTMLElementImpl
		implements HTMLHtmlElement
	{
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "html";
		
		/**
		* 	Creates an <code>HTMLHtmlElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function HTMLHtmlElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = NAME )
		{
			super( owner, name );
		}
	}
}