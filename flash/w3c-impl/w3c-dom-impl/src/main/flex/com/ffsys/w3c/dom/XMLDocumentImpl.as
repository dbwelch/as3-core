package com.ffsys.w3c.dom
{
	import com.ffsys.w3c.dom.core.DocumentImpl;
	import org.w3c.dom.*;
	
	public class XMLDocumentImpl extends DocumentImpl
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