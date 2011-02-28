package com.ffsys.w3c.dom.xml
{
	import org.w3c.dom.Element;
	import org.w3c.dom.NodeList;
	
	import com.ffsys.w3c.dom.DocumentImpl;
	
	/**
	* 	Represents an XML DOM document.
	*/
	public class XMLDocumentImpl extends DocumentImpl
	{
		/**
		* 	The bean name for an XML document.
		*/
		public static const NAME:String = "dom-xml-doc";		
			
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