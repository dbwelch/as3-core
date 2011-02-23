package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	* 	Represents a DOM implementation for the
	* 	"XML" feature.
	*/
	public class XMLImplementationImpl extends DOMImplementationImpl
	{	
		/**
		* 	Creates an <code>XMLImplementationImpl</code> instance.
		*/
		public function XMLImplementationImpl()
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