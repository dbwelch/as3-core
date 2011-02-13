package com.ffsys.dom
{
	import com.ffsys.dom.core.DocumentImpl;
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