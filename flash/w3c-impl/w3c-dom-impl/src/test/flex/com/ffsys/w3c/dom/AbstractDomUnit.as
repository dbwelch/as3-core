package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.*;
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.bootstrap.DOMImplementationRegistry;
	import org.w3c.dom.html.HTMLDocument;
	import org.w3c.dom.html.HTMLDOMImplementation;	
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class AbstractDomUnit extends Object
	{
		
		private var _document:Document;
		private var _htmlDocument:HTMLDocument;
		
		/**
		*	Creates an <code>AbstractDomUnit</code> instance.
		*/ 
		public function AbstractDomUnit()
		{
			super();
		}
		
		protected function getRegistry():DOMImplementationRegistry
		{
			//create the bean document for bootstrap
			var beans:IBeanDocument = new DOMBootstrap();	
			//get the DOM registry
			var registry:DOMImplementationRegistry = DOMImplementationRegistry(
				beans.getBean( DOMBootstrap.DOM_REGISTRY ) );
			Assert.assertNotNull( registry );
			return registry;			
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
			
			var registry:DOMImplementationRegistry = getRegistry();
			
			//retrieve an implementation for "HTML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.HTML_MODULE
				+ " " + DOMFeature.LEVEL_3 + " " + DOMFeature.CORE_MODULE );
			
			Assert.assertNotNull( impl );
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
		* 	Creates a XML document.
		*/
		protected function getXMLDocument():Document
		{
			if( _document != null )
			{
				return _document;
			}

			var registry:DOMImplementationRegistry = getRegistry();
			
			//retrieve an implementation for "XML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.XML_MODULE
				+ " " + DOMFeature.LEVEL_3 + " " + DOMFeature.CORE_MODULE );
			Assert.assertNotNull( impl );
			
			//create a null doctype
			var doctype:DocumentType = impl.createDocumentType(
				null, null, null );
			Assert.assertNotNull( doctype );
			
			//create a plain xml document implementation
			var doc:Document = impl.createDocument( null, "html", doctype );
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );

			Assert.assertEquals( "html", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );
			_document = doc;
			return _document;
		}
	}
}