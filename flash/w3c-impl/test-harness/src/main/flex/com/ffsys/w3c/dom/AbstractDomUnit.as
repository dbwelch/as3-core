package com.ffsys.w3c.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.*;
	import com.ffsys.w3c.dom.bootstrap.DOMImplementationRegistry;
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;	
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	import com.ffsys.w3c.dom.ls.LSOutputImpl;	
	
	import org.w3c.dom.Document;
	import org.w3c.dom.DocumentType;
	import org.w3c.dom.Element;
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.DOMFeature;
	import org.w3c.dom.DOMImplementation;
	import org.w3c.dom.DOMImplementationSource;
	import org.w3c.dom.DOMVersion;
	
	import org.w3c.dom.ls.LSSerializer;	
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.DOMImplementationLS;
	
	import org.w3c.dom.html.HTMLDocument;
	import org.w3c.dom.html.HTMLDOMImplementation;
	
	import com.ffsys.w3c.dom.bootstrap.DOMCoreBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMEventsBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMLSBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMLSAsyncBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMViewsBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMCSSBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMXMLBootstrap;
	import com.ffsys.w3c.dom.bootstrap.DOMHTMLBootstrap;							
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class AbstractDomUnit extends Object
	{
		static private var _registry:DOMImplementationRegistry;		
		
		/**
		* 	@private
		*/
		protected var _document:Document;
		
		//TODO: remove this
		private var _htmlDocument:HTMLDocument;
		
		/**
		*	Creates an <code>AbstractDomUnit</code> instance.
		*/ 
		public function AbstractDomUnit()
		{
			super();
		}
		
		/**
		* 	@private
		* 
		* 	Retrieve the main DOM implementation registry.
		*/
		protected function getRegistry( impls:Vector.<DOMImplementationSource> = null ):DOMImplementationRegistry
		{
			//get the DOM registry
			//if( _registry == null )
			//{
				_registry = DOMImplementationRegistry.newInstance();
				_registry.clear();
				
				//TODO: move these defaults to be runtime system properties
				
				//no specific types to bootstrap
				if( impls == null )
				{
					addDefaultRegistryImplementationSources( _registry );
				}else{
					for( var i:int = 0;i < impls.length;i++ )
					{
						_registry.addSource( impls[ i ] );
					}
				}
								
				Assert.assertNotNull( _registry );
			//}
			return _registry;
		}
		
		/**
		* 	@private
		*/
		protected function addDefaultRegistryImplementationSources(
			registry:DOMImplementationRegistry ):void
		{
			registry.addSource( new DOMCoreBootstrap() );
			registry.addSource( new DOMEventsBootstrap() );
			registry.addSource( new DOMLSBootstrap() );
			registry.addSource( new DOMLSAsyncBootstrap() );
			registry.addSource( new DOMViewsBootstrap() );
			registry.addSource( new DOMCSSBootstrap() );
			registry.addSource( new DOMXMLBootstrap() );
			registry.addSource( new DOMHTMLBootstrap() );
		}
		
		/**
		* 	@private
		* 
		* 	Finds the first available implementation source
		* 	that is of the specified type.
		* 
		* 	@param type The type of implementation source.
		* 
		* 	@return The first implementation source of the specified type
		* 	if found.
		*/
		protected function getImplementationSource( type:Class ):DOMImplementationSource
		{
			var registry:DOMImplementationRegistry = getRegistry();
			var sources:Vector.<DOMImplementationSource> = registry.sources;
			var src:DOMImplementationSource = null;
			for( var i:int = 0;i < sources.length;i++ )
			{
				src = sources[ i ];
				if( src is type )
				{
					return src;
				}
			}
			return null;
		}
		
		/**
		* 	@private
		* 
		* 	Retrieve an XML DOM implementation.
		* 
		* 	@return An XML implementation.
		*/
		protected function getXMLImplementation():DOMImplementation
		{
			//get the DOM registry
			var registry:DOMImplementationRegistry = getRegistry();
			//retrieve an implementation for "XML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.XML_MODULE
				+ " " + DOMVersion.LEVEL_3 + " " + DOMFeature.CORE_MODULE );
			Assert.assertNotNull( impl );
			return impl;
		}
		
		/**
		* 	@private
		* 
		* 	Retrieve an HTML DOM implementation.
		* 
		* 	@return An HTML implementation.
		*/
		protected function getHTMLImplementation():DOMImplementation
		{
			//get the DOM registry
			var registry:DOMImplementationRegistry = getRegistry();
			//retrieve an implementation for "HTML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.HTML_MODULE
				+ " " + DOMVersion.LEVEL_2 + " " + DOMFeature.CORE_MODULE );
			Assert.assertNotNull( impl );
			return impl;
		}
		
		/**
		* 	Creates an HTML document.
		*/
		protected function getHTMLDocument():HTMLDocument
		{
			if( _htmlDocument != null )
			{
				return _htmlDocument;
			}
			
			var title:String = "this is a document title";
			
			var impl:DOMImplementation = getHTMLImplementation();
			Assert.assertTrue( impl is HTMLDOMImplementation );
			
			//create a plain xml document implementation
			var doc:HTMLDocument = HTMLDOMImplementation( impl ).createHTMLDocument(
				title );
			Assert.assertNotNull( doc );
			Assert.assertEquals( title, doc.title );
				
			/*
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );

			Assert.assertEquals( "html", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );
			*/
			
			_htmlDocument = doc;
			return _htmlDocument;			
		}		
		
		/**
		* 	Creates an XML document.
		*/
		protected function getXMLDocument():Document
		{
			if( _document != null )
			{
				return _document;
			}
			
			//retrieve an implementation for "XML 3.0 Core"
			var impl:DOMImplementation = getXMLImplementation();
			
			
			
			Assert.assertTrue( impl is XMLDOMImplementationImpl );
			
			//create a null doctype
			var doctype:DocumentType = impl.createDocumentType(
				null, null, null );
			Assert.assertNotNull( doctype );
			
			//create a plain xml document implementation
			var doc:Document = impl.createDocument( null, "xml-root", doctype );
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );

			Assert.assertEquals( "xml-root", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );
			
			_document = doc;
			return _document;
		}
		
		
		/**
		* 	@private
		*/
		protected function serializeToNativeXML(
			doc:Document, namespaces:Vector.<Namespace> = null ):XML
		{
			Assert.assertNotNull( doc );
			
			var impl:DOMImplementationLS = DOMImplementationLS( doc.implementation );
			Assert.assertNotNull( impl );
			
			//create a serializer
			var serializer:LSSerializer = impl.createLSSerializer();
			Assert.assertNotNull( serializer );	
			
			var config:DOMConfiguration = serializer as DOMConfiguration;
			config.setParameter( "xml-declaration", false );
			
			//TODO: check for an existing defined parameter
			config.setParameter( "xml-namespaces", namespaces );
			Assert.assertNotNull( config );
			
			var output:LSOutput = impl.createLSOutput();
			Assert.assertNotNull( output );
		
			LSOutputImpl( output ).e4x = new XML();
			serializer.write( doc, output );
			return LSOutputImpl( output ).e4x;
		}
	}
}