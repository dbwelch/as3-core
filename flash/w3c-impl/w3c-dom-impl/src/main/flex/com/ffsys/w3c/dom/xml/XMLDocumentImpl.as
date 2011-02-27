package com.ffsys.w3c.dom.xml
{
	import org.w3c.dom.Element;
	import org.w3c.dom.NodeList;
	
	import com.ffsys.w3c.dom.DocumentImpl;
	
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
		* 	@inheritDoc
		*/
		override public function get documentElement():Element
		{
			var el:Element = null;
			var elements:NodeList = this.getElements();
			
			if( elements.length > 1 )
			{
				//TODO: handle this potential error case (multiple top-level XML elements), 
				//when appending child nodes not here
			}
			
			if( elements.length >= 1 )
			{
				el = elements[ 0 ];
			}
			return el;
		}
	}
}