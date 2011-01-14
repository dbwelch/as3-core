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
		* 	Represents the DOM level 2.
		*/
		public static const LEVEL_2:uint = 2;
		
		/**
		* 	Represents the DOM level 3.
		*/
		public static const LEVEL_3:uint = 3;
				
		//
		private var _beanManager:IBeanManager;
		
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
		* 	Gets the current target DOM implementation level.
		*/
		public function get level():uint
		{
			return LEVEL_2;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanManager():IBeanManager
		{
			if( _beanManager == null )
			{
				_beanManager = new DomBeanManager();
			}
			return _beanManager;
		}
		
		public function set beanManager( value:IBeanManager ):void
		{
			_beanManager = value;
		}
		
		/**
		* 	Parses a source <code>XML</code> document
		* 	as if it is an <code>XHTML</code> document.
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
			
			//var qualifiedName:String = source.name().localName;
			//var namespaceURI:String = source.@xmlns.length() > 0 ? source.@xmlns.toString() : DEFAULT_NAMESPACE_URI;
			
			/*
			var doc:Document = createDocument(
				namespaceURI, qualifiedName, doctype );
			doc.xml = source;
			*/
			
			//var beans:IBeanDocument = doctype.elements;
			
			var parser:DomSaxParser = new DomSaxParser( this, doctype );
				
			//parser.root = doc;
			//parser.document = beans;
			
			//parser.document.id = namespaceURI;
			
			parser.parse( source );
			
			return parser.dom;
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
			//This method can raise a DOMException object.
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
			//This method can raise a DOMException object.
			var document:Document = Document( doctype.elements.getBean(
				qualifiedName ) );
			document.setImplementation( this );
			document.setDocumentType( doctype );
			return document;
		}
	}
}