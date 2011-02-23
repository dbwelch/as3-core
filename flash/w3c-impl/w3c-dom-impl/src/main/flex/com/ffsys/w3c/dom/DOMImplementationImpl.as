package com.ffsys.w3c.dom
{
	import flash.net.URLRequest;
	import com.ffsys.ioc.*;
	
	import com.ffsys.w3c.dom.support.*;
	import com.ffsys.w3c.dom.ioc.*;
	import org.w3c.dom.*;
	
	/**
	*	Represents the <code>DOM</code> implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DOMImplementationImpl extends AbstractNodeProxyImpl
		implements DOMImplementation
	{
		/**
		* 	The optional character that may appear
		* 	at the beginning of a feature name.
		*/
		public static const PLUS:String = "+";		
		
		/**
		* 	The delimiter between a feature name
		* 	and the optional associated version.
		*/
		public static const MODULE_VERSION_DELIMITER:String = " ";
				
		private var _supported:Vector.<DOMFeature>;
		
		/**
		* 	Creates a <code>DOMImplementationImpl</code> instance.
		* 
		* 	@param manager A specific bean manager to use for
		* 	element instantiation.
		*/
		public function DOMImplementationImpl(
			manager:IBeanManager = null )
		{
			super();
			configureSupportedFeatures();
		}
		
		/**
		* 	A convenience method for implementations to generate
		* 	an identifier consisting of a feature name optionally
		* 	concatenated with a version.
		* 
		* 	@param feature The DOM feature.
		* 	@param version The version number.
		* 
		* 	@return A full feature and version string
		* 	delimited with whitespace.
		*/
		static public function getQualifiedFeatureName(
			feature:String, version:String = null ):String
		{
			var nm:String = feature;
			if( version != null )
			{
				nm += MODULE_VERSION_DELIMITER + version;
			}
			return nm;
		}
		
		/*
		
		"-//W3C//DTD XHTML Basic 1.1//EN"
			"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"		
		
		
		*/
		
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
			//TODO - change default DOCTYPE
			//return DocumentType.XHTML_1_STRICT;
			
			return null;
		}
		
		/**
		* 	Invoked when an implementation is instantiated
		* 	to configure the features supported by this
		* 	implementation.
		* 
		* 	This method does nothing by default, derived
		* 	implementations should override this method
		* 	and configure the features that are supported
		* 	by the implementation.
		*/
		protected function configureSupportedFeatures():void
		{
			//
		}
		
		/**
		* 	A list of features supported by this implementation.
		* 
		* 	If no supported features have been configured (the first
		* 	time this accessor is accessed) then a list is created
		* 	containing the <code>DOMFeature.CORE_FEATURE</code>
		* 	feature which is required for every implementation.
		*/
		public function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = new Vector.<DOMFeature>();
				_supported.push( DOMFeature.CORE_FEATURE );
				_supported.push( DOMFeature.XML_FEATURE );
				
				_supported.push( DOMFeature.EVENTS_FEATURE );
				_supported.push( DOMFeature.UI_EVENTS_FEATURE );
				_supported.push( DOMFeature.MOUSE_EVENTS_FEATURE );
				_supported.push( DOMFeature.TEXT_EVENTS_FEATURE );
				_supported.push( DOMFeature.KEYBOARD_EVENTS_FEATURE );
				_supported.push( DOMFeature.MUTATION_EVENTS_FEATURE );
				_supported.push( DOMFeature.MUTATION_NAME_EVENTS_FEATURE );
				
				_supported.push( DOMFeature.LS_FEATURE );
				_supported.push( DOMFeature.LS_ASYNC_FEATURE );
				
				_supported.push( DOMFeature.VIEWS_FEATURE );
			}
			return _supported;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFeature(
			feature:String, version:String ):Object
		{
			trace("DOMImplementationImpl::getFeature()",
				feature, version, supported, this.document );
				
			var bean:Object = null;
			
			try
			{
				bean = this.document.getBean( feature );
			}catch( e:Error )
			{
				//could be a null bean document if not
				//instantiated via IoC
			}
			
			return bean;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasFeature(
			feature:String, version:String ):Boolean
		{
			var ft:DOMFeature = null;
			for( var i:int = 0;i < supported.length;i++ )
			{
				ft = supported[ i ];
				if( ft.hasFeature( feature, version ) )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createDocumentType( 
			qualifiedName:String,
			publicId:String,
			systemId:String ):DocumentType
		{
			//This method can raise a DomException object.
			var docType:DocumentType = new DocumentTypeImpl(
				qualifiedName, systemId, publicId );
			return docType;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document
		{
			//trace("DOMImplementationImpl::getDefaultDocumentType()", qualifiedName );
			
			//This method can raise a DomException object.
			var document:Document = Document(
				DocumentTypeImpl( doctype ).beans.getBean(
					qualifiedName ) );
			if( namespaceURI != null )
			{
				NodeImpl( document ).namespaceDeclarations.push(
					new Namespace( namespaceURI ) );
			}
			setImplementation( document, doctype );
			return document;
		}
		
		/**
		* 	@private
		*/
		protected function setImplementation( document:Document, doctype:DocumentType ):void
		{
			DocumentImpl( document ).setDocumentType( doctype );
			DocumentImpl( document ).setImplementation( this );
		}
	}
}