package com.ffsys.w3c.dom.xml
{
	import org.w3c.dom.*;
	
	import com.ffsys.w3c.dom.DOMBootstrap;
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	import com.ffsys.w3c.dom.NodeImpl;
	
	/**
	* 	Represents a DOM implementation for the
	* 	"XML" feature.
	*/
	public class XMLDOMImplementationImpl extends DOMImplementationImpl
	{	
		/**
		* 	Creates an <code>XMLDOMImplementationImpl</code> instance.
		*/
		public function XMLDOMImplementationImpl()
		{
			super();
		}
		
		/**
		* 	Configures the supported features for this implementation.
		*/
		override protected function configureSupportedFeatures():void
		{
			this.supported.push( DOMFeature.XML_FEATURE );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document
		{
			//trace("DOMImplementationImpl::getDefaultDocumentType()", qualifiedName );
			
			var document:XMLDocumentImpl = XMLDocumentImpl(
				this.document.getBean( DOMBootstrap.XML_DOCUMENT ) );
			
			if( namespaceURI != null )
			{
				NodeImpl( document ).namespaceDeclarations.push(
					new Namespace( namespaceURI ) );
			}
			
			var e:Element = document.createElement( qualifiedName );
			document.setDocumentElement( e );
			
			//TOOD: handle inspecting the doctype and 
			//retrieving more specialized implementations where appropriate
			
			setImplementation( document, doctype );
			
			return document;
		}
	}
}