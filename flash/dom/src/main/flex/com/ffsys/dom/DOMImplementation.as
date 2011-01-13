package com.ffsys.dom
{
	import com.ffsys.dom.xhtml.*;
	import com.ffsys.ioc.*;
	
	/**
	*	Represents the <code>DOM</code> implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DOMImplementation extends Object
	{
		public static const COMPONENTS_NAME:String = "dom-components";
		
		public static const VERSION_1:String = "1.0";
		
		public static const VERSION_1_1:String = "1.1";		
		
		public static const VERSION_2_0:String = "2.0";
		
		private var _beanManager:IBeanManager;
		private var _components:IBeanDocument;
		
		/**
		* 	Creates a <code>DOMImplementation</code> instance.
		* 
		* 	@param manager A specific bean manager to use for
		* 	element instantiation.
		*/
		public function DOMImplementation(
			manager:IBeanManager = null )
		{
			super();
			this.beanManager = manager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanManager():IBeanManager
		{
			if( _beanManager == null )
			{
				_beanManager = new DomBeanManager(
					new XhtmlBeanDocument() );
			}
			return _beanManager;
		}
		
		public function set beanManager( value:IBeanManager ):void
		{
			_beanManager = value;
		}
		
		/**
		* 	The primary bean document that defines the
		* 	DOM elements.
		*/
		public function get document():IBeanDocument
		{
			return beanManager.document;
		}
		
		/**
		* 	A bean document that defines visual components
		* 	to be attached to visual DOM elements.
		*/
		public function get components():IBeanDocument
		{
			if( _components == null )
			{
				_components = new BeanDocument();
				_components.id = COMPONENTS_NAME;
			}
			return _components;
		}
		
		public function set components( value:IBeanDocument ):void
		{
			_components = value;
		}
		
		public function parse( source:XML ):Document
		{
			//qualifiedName:String, publicId:String, systemId:String
			
			if( source == null || !source.name() )
			{
				return null;
			}
			
			var qualifiedName:String = source.name().localName;
			var namespaceURI:String = source.@xmlns;
			var docType:DocumentType = getXhtmlDocumentType();
			
			var doc:Document = createDocument(
				namespaceURI, qualifiedName, docType );
			doc.xml = source;
			
			var parser:DomSaxParser = new DomSaxParser();
			parser.root = doc;
			parser.document = this.document;
			parser.parse( source );
				
			return doc;
		}
		
		public function hasFeature( feature:String, version:String ):Boolean
		{
			return false;
		}
		
		private function getXhtmlDocumentType(
			qualifiedName:String = null,
			namespaceURI:String = null,
			version:String = VERSION_1 ):DocumentType
		{
			var qualifiedName:String = "html";
			var publicId:String = null;
			var systemId:String = null;
			
			switch( version )
			{
				case VERSION_1:
					systemId = "\"-//W3C//DTD XHTML 1.0 Strict//EN\"";
					publicId = "\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"";
					break;
			}
			
			
			
			/*
			<!DOCTYPE html PUBLIC 
				"-//W3C//DTD XHTML Basic 1.1//EN"
				"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
			
			*/
			
			// "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"
			
			// "-//W3C//DTD XHTML Basic 1.1//EN"
			
			return createDocumentType( qualifiedName, publicId, systemId );
		}
		
		public function createDocumentType( 
			qualifiedName:String, publicId:String, systemId:String ):DocumentType
		{
			var docType:DocumentType = new DocumentType();
			
			var x:XML = new XML( "<doctype><![CDATA[<!DOCTYPE "
				+ qualifiedName
				+ " PUBLIC \""
				+ systemId
				+ "\" \""
				+ publicId + "\">]]></doctype>" );
				
			trace("[DOCTYPE] DOMImplementation::createDocumentType()", x.toXMLString() );
			
			docType.xml = x;
			return docType;
		}
		
		public function createDocument(
			namespaceURI:String, qualifiedName:String, docType:DocumentType ):Document
		{
			var document:Document = Document( this.document.getBean(
				qualifiedName ) );
			document.setImplementation( this );
			document.setDocumentType( docType );
			return document;
		}
	
		/*
	
		Object DOMImplementation
		The DOMImplementation object has the following methods:
		hasFeature(feature, version)
		This method returns a Boolean.
		The feature parameter is of type String.
		The version parameter is of type String.
		createDocumentType(qualifiedName, publicId, systemId)
		This method returns a DocumentType object.
		The qualifiedName parameter is of type String.
		The publicId parameter is of type String.
		The systemId parameter is of type String.
		This method can raise a DOMException object.
		createDocument(namespaceURI, qualifiedName, doctype)
		This method returns a Document object.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
		The doctype parameter is a DocumentType object.
		This method can raise a DOMException object.	
	
	
	
		*/
	
	}

}