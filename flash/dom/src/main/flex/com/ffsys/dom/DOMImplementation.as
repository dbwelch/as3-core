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
		/**
		* 	The name of the bean document that
		* 	contains components to attach to
		* 	visual DOM elements.
		*/
		public static const COMPONENTS_NAME:String = "dom-components";
		
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
		
		/**
		* 	Parses a source <code>XML</code> document
		* 	as if it is an <code>XHTML<code> document.
		* 
		* 	@param source The source <code>XML</code> document.
		* 	@param doctype A specific document type to use when
		* 	parsing the source.
		*/
		public function parse(
			source:XML, 
			doctype:DocumentType = null ):Document
		{
			if( source == null || !source.name() )
			{
				return null;
			}
			
			if( doctype == null )
			{
				//default document type for the moment
				doctype = DocumentType.XHTML_1_STRICT;
			}
			
			var qualifiedName:String = source.name().localName;
			var namespaceURI:String = source.@xmlns;
			var docType:DocumentType = doctype;
			
			var doc:Document = createDocument(
				namespaceURI, qualifiedName, docType );
			doc.xml = source;
			
			var parser:DomSaxParser = new DomSaxParser();
			parser.root = doc;
			parser.document = this.document;
			parser.parse( source );
				
			return doc;
		}
		
		/**
		* 	Determines whether this implementation
		* 	has a specific feature.
		*/
		public function hasFeature(
			feature:String, version:String ):Boolean
		{
			return false;
		}
		
		/**
		* 	Creates a document type.
		* 
		* 	@param qualifiedName The qualified name for the document type.
		* 	@param publicId The public identifier for the document type.
		* 	@param systemId The system identifier for the document type.
		* 	
		* 	@return The created document type.
		*/
		public function createDocumentType( 
			qualifiedName:String,
			publicId:String,
			systemId:String ):DocumentType
		{
			var docType:DocumentType = new DocumentType( qualifiedName, systemId, publicId );
			return docType;
		}
		
		/**
		* 	Creates a document.
		* 
		* 	@param namespaceURI The <code>URI</code> for the document namespace.
		* 	@param qualifiedName The qualified name for the document.
		* 	@param doctype The document type definition.
		*/
		public function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document
		{
			var document:Document = Document( this.document.getBean(
				qualifiedName ) );
			document.setImplementation( this );
			document.setDocumentType( doctype );
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