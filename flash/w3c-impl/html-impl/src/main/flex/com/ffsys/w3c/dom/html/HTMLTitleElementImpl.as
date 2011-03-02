package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLTitleElement;
	
	/**
	* 	Represents the title of an HTML document.
	*/
	public class HTMLTitleElementImpl extends HTMLElementImpl
		implements HTMLTitleElement
	{
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "title";
		
		/**
		* 	Creates an <code>HTMLTitleElementImpl</code> instance.
		*/
		public function HTMLTitleElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = NAME )
		{
			super( owner, name );
		}
		
		/**
		* 	The text for this title.
		*/
		public function get text():String
		{
			return String( setText() );
		}
		
		public function set text( text:String ):void
		{
			setText( text );
		}
	}
}