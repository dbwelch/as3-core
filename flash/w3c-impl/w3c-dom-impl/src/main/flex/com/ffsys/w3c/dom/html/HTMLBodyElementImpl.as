package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLBodyElement;

	public class HTMLBodyElementImpl extends HTMLElementImpl
		implements HTMLBodyElement
	{
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "body";
		
		/**
		* 	Creates an <code>HTMLBodyElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function HTMLBodyElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = NAME )
		{
			super( owner, name );
		}
	}
}