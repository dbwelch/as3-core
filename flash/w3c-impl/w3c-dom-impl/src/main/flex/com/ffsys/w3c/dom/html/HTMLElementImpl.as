package com.ffsys.w3c.dom.html
{
	import com.ffsys.w3c.dom.ElementImpl;
	
	import org.w3c.dom.html.HTMLElement;

	public class HTMLElementImpl extends ElementImpl
		implements HTMLElement
	{
		
		/**
		* 	Creates an <code>HTMLElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function HTMLElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = null )
		{
			super( owner, name );
		}
	}
}