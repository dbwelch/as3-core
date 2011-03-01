package com.ffsys.w3c.dom
{
	import flash.net.URLRequest;
	
	import com.ffsys.w3c.dom.support.*;
	
	import org.w3c.dom.*;
	
	import org.w3c.dom.ls.DOMImplementationLS;
	import org.w3c.dom.ls.LSInput;	
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.LSParser;	
	
	import org.w3c.dom.range.DocumentRange;
	import org.w3c.dom.range.Range;	
	
	import org.w3c.dom.traversal.DocumentTraversal;
	import org.w3c.dom.traversal.NodeFilter;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.TreeWalker;	
	
	import com.ffsys.w3c.dom.range.RangeImpl;
	import com.ffsys.w3c.dom.traversal.NodeIteratorImpl;
	
	
	/**
	*	Encapsulates the core <code>DOM</code> implementation features.
	* 
	* 	<p>Supported DOM features:</p>
	* 
	* 	<ol>
	* 		<li><code>Core</code></li>
	* 		<li><code>ElementTraversal</code></li>
	* 		<li><code>Range</code></li>
	* 		<li><code>Traversal</code></li>
	* 	</ol>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DOMImplementationImpl extends AbstractNodeProxyImpl
		implements DOMImplementation, DocumentTraversal, DocumentRange
	{			
		
		/**
		* 	The bean name for the DOM Core implementation.
		*/
		public static const NAME:String = DOMFeature.CORE_MODULE;
		
		/**
		* 	@private
		*/	
		protected var _supported:Vector.<DOMFeature>;
		
		/**
		* 	Creates a <code>DOMImplementationImpl</code> instance.
		*/
		public function DOMImplementationImpl()
		{
			super();
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
		* 	@private
		* 	
		* 	A list of features supported by this implementation.
		* 
		* 	If no supported features have been configured (the first
		* 	time this accessor is accessed) then a list is created
		* 	containing the <code>DOMFeature.CORE_FEATURE</code>
		* 	feature which is required for every implementation.
		*/
		protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = new Vector.<DOMFeature>();
				_supported.push( DOMFeature.CORE_FEATURE );
				_supported.push( DOMFeature.CORE_3_FEATURE );
				_supported.push( DOMFeature.RANGE_FEATURE );
				_supported.push( DOMFeature.RANGE_3_FEATURE );
				_supported.push( DOMFeature.TRAVERSAL_FEATURE );
				_supported.push( DOMFeature.TRAVERSAL_3_FEATURE );
				_supported.push( DOMFeature.ELEMENT_TRAVERSAL_FEATURE );
				_supported.push( DOMFeature.ELEMENT_TRAVERSAL_3_FEATURE );
			}
			return _supported;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFeature(
			feature:String, version:String ):Object
		{
			var self:Object = isFeature( feature, version );
			if( self != null )
			{
				return self;
			}
			
			/*
			trace("DOMImplementationImpl::getFeature()",
				feature, version, supported, this.document );
			*/
				
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
		* 	@private
		*/
		protected function isFeature(
			feature:String, version:String ):Object
		{
			for( var i:int = 0;i < supported.length;i++ )
			{
				if( supported[ i ].equals( feature, version ) )
				{
					return this;
				}
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasFeature(
			feature:String, version:String ):Boolean
		{
			var self:Object = isFeature( feature, version );
			if( self === this )
			{
				return true;
			}
			
			var ft:DOMFeature = null;
			for( var i:int = 0;i < supported.length;i++ )
			{
				ft = supported[ i ];
				if( ft.equals( feature, version ) )
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
				null,
				qualifiedName,
				systemId,
				publicId );
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
			throw new Error(
				"The document must be created by a derived DOM implementation." );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createRange():Range
		{
			var bean:Object = null;
			try
			{
				bean = this.document.getBean(
					RangeImpl.NAME );
			}catch( e:Error )
			{
				//no bean document assigned most likely
				//not instantiated via IoC
				bean = new RangeImpl();
			}
			return Range( bean );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createNodeIterator(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):NodeIterator
		{
			var bean:Object = null;
			try
			{
				bean = this.document.getBean(
					NodeIteratorImpl.NAME );
			}catch( e:Error )
			{
				//no bean document assigned most likely
				//not instantiated via IoC
				bean = new NodeIteratorImpl();
			}
			
			var iterator:NodeIterator = NodeIterator( bean );
			
			//TODO: set all the iterator properties
			
			return iterator;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTreeWalker(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):TreeWalker
		{
			//TODO
			return null;
		}		
		
		/**
		* 	@private
		*/
		protected function setImplementation( document:Document, doctype:DocumentType ):void
		{
			CoreDocumentImpl( document ).setDocumentType( doctype );
			CoreDocumentImpl( document ).setImplementation( this );
		}
	}
}