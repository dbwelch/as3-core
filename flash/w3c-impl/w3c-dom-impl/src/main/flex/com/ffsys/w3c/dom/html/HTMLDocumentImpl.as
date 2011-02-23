package com.ffsys.w3c.dom.html
{
	import com.ffsys.w3c.dom.DocumentImpl;
	
	import org.w3c.dom.Element;
	import org.w3c.dom.html.HTMLDocument;
	
	public class HTMLDocumentImpl extends DocumentImpl
		implements HTMLDocument
	{
		/**
		* 	@private
		* 
		* 	Creates an <code>HTMLDocumentImpl</code> instance.
		*/
		public function HTMLDocumentImpl()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		internal function setDocumentElement( element:Element ):void
		{
			_documentElement = element;
		}
	}
}