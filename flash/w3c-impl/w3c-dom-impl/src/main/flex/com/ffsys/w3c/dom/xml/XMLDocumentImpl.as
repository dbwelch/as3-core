package com.ffsys.w3c.dom.xml
{
	import org.w3c.dom.Element;
	
	import com.ffsys.w3c.dom.CoreDocumentImpl;
	
	
	public class XMLDocumentImpl extends CoreDocumentImpl
	{	
		/**
		* 	Creates an <code>XMLDocumentImpl</code> instance.
		*/
		public function XMLDocumentImpl()
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