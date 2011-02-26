package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.*;
	import com.ffsys.w3c.dom.bootstrap.DOMImplementationRegistry;
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;	
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
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
		
		/**
		* 	@private
		* 
		* 	Retrieve the main DOM implementation registry.
		*/
		protected function getRegistry():DOMImplementationRegistry
		{
			//get the DOM registry
			var registry:DOMImplementationRegistry =
				DOMImplementationRegistry.newInstance();
			Assert.assertNotNull( registry );
			return registry;
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
				+ " " + DOMFeature.LEVEL_3 + " " + DOMFeature.CORE_MODULE );
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
				+ " " + DOMFeature.LEVEL_3 + " " + DOMFeature.CORE_MODULE );
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