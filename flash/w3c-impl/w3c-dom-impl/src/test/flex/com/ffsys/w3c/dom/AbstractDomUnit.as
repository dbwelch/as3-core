package com.ffsys.w3c.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.*;
	import com.ffsys.w3c.dom.bootstrap.DOMImplementationRegistry;
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;	
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	import org.w3c.dom.Document;
	import org.w3c.dom.DocumentType;
	import org.w3c.dom.Element;
	import org.w3c.dom.DOMImplementation;
	import org.w3c.dom.DOMImplementationSource;
	import org.w3c.dom.DOMException;
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
		
		private var _document:Document;
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
					_registry.addSource( new DOMCoreBootstrap() );
					_registry.addSource( new DOMEventsBootstrap() );
					_registry.addSource( new DOMLSBootstrap() );
					_registry.addSource( new DOMLSAsyncBootstrap() );
					_registry.addSource( new DOMViewsBootstrap() );
					_registry.addSource( new DOMCSSBootstrap() );
					_registry.addSource( new DOMXMLBootstrap() );
					_registry.addSource( new DOMHTMLBootstrap() );
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
	}
}