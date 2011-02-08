package com.ffsys.dom.core
{
	import flash.net.URLRequest;
	import com.ffsys.dom.xhtml.*;
	import com.ffsys.ioc.*;
	
	import com.ffsys.dom.*;
	
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
		public static const LEVEL_2:String = "2.0";
		
		/**
		* 	Represents the DOM level 3.
		*/
		public static const LEVEL_3:String = "3.0";
				
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
		
		/*
		
		"-//W3C//DTD XHTML Basic 1.1//EN"
			"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"		
		
		
		*/
		
		/**
		* 	Gets the current target DOM implementation level.
		*/
		public function get level():String
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
				
				//main document is XHTML 1.0 strict until an HTML5 upgrade ;)
				_beanManager.document = new XhtmlBeanDocument(
					"-//W3C//DTD XHTML 1.0 Strict//EN" );
					
				//add the other known document types
				_beanManager.documents.push(
					new XhtmlBeanDocument(
					"-//W3C//DTD XHTML 1.1//EN" ) );
			}
			return _beanManager;
		}
		
		public function set beanManager( value:IBeanManager ):void
		{
			_beanManager = value;
		}
		
		/**
		* 	@private
		*/
		internal function getBeanDocumentFromDtd(
			definition:DocumentTypeDefinition ):IBeanDocument
		{
			var document:IBeanDocument = null
			var publicId:String = definition.publicId;
			
			if( publicId == beanManager.document.id )
			{
				document = beanManager.document;
			}
			
			if( document == null )
			{
				for each( var doc:IBeanDocument in beanManager.documents )
				{
					if( publicId == doc.id )
					{
						document = doc;
						break;
					}
				}
			}
			
			//trace("DOMImplementation::getBeanDocumentFromDtd()", publicId, document );
			
			return document;
		}
		
		/**
		* 	Parses a source <code>XML</code> document
		* 	as if it is an <code>XHTML</code> document.
		* 
		* 	@param source The source <code>XML</code> document.
		* 	@param doctype A specific document type to use when
		* 	parsing the source.
		* 	@param target A target element to parse the document
		* 	into.
		*/
		public function parse(
			source:XML,
			doctype:DocumentType = null,
			target:Element = null ):Element
		{
			if( source == null || !source.name() )
			{
				return null;
			}
			
			//TODO: cache the document type for partials parsed into an existing DOM
			if( doctype == null )
			{
				doctype = getDefaultDocumentType();
			}
			
			var parser:DomSaxParser = new DomSaxParser( this, doctype );
			if( target != null )
			{
				parser.root = target;
			}
			parser.parse( source );
			return Element( parser.element );
		}
		
		/**
		* 	Loads a DOM document using a streaming SAX
		* 	parser.
		* 
		* 	@param request The <code>URL</code> request.
		* 
		* 	@return The parser responsible for loading and
		* 	parsing the DOM.
		*/
		public function load( request:URLRequest ):DomSaxParser
		{
			var parser:DomSaxParser = new DomSaxParser( this, null );
			parser.load( request );
			return parser;
		}
		
		/**
		*	Retrieves a DOM SAX parser with no configured
		* 	document type ready for a load operation.
		* 
		* 	@return A SAX parser implementation suitable
		* 	for loading a DOM document.
		*/
		public function parser():DomSaxParser
		{
			var parser:DomSaxParser = new DomSaxParser(
				this, null );
			return parser;
		}
		
		public function fragment(
			source:XML,
			doctype:DocumentType = null ):DocumentFragment
		{
			if( source == null || !source.name() )
			{
				return null;
			}
			
			if( doctype == null )
			{
				doctype = getDefaultDocumentType();
			}
			
			var parser:DomSaxParser = new DomSaxParser( this, doctype );
			parser.fragment( source );
			return DocumentFragment( parser.element );
		}
		
		private function getDefaultDocumentType():DocumentType
		{
			return DocumentType.XHTML_1_STRICT;
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
			//This method can raise a DomException object.
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
			//trace("DOMImplementation::getDefaultDocumentType()", qualifiedName );
			
			//This method can raise a DomException object.
			var document:Document = Document( doctype.elements.getBean(
				qualifiedName ) );
			if( namespaceURI != null )
			{
				document.namespaceDeclarations.push(
					new Namespace( namespaceURI ) );
			}
			document.setImplementation( this );
			document.setDocumentType( doctype );
			return document;
		}
	}
}