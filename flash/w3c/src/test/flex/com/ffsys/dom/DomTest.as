package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.*;
	import com.ffsys.dom.core.*;
	import org.w3c.dom.*;
	import org.w3c.dom.bootstrap.DOMImplementationRegistry;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class DomTest extends Object
	{
		
		private var _document:Document;
		
		/**
		*	Creates a <code>DomTest</code> instance.
		*/ 
		public function DomTest()
		{
			super();
		}
		
		/**
		* 	Creates a document
		*/
		protected function getDocument():Document
		{
			if( _document != null )
			{
				return _document;
			}
			
			//create the bean document for bootstrap
			var beans:IBeanDocument = new DOMBootstrap();
			
			//get the DOM registry
			var registry:DOMImplementationRegistry = DOMImplementationRegistry(
				beans.getBean( DOMBootstrap.DOM_REGISTRY ) );
			Assert.assertNotNull( registry );
			
			//retrieve and implementation for "XML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.XML_MODULE + " 3.0 " + DOMFeature.CORE_MODULE );
			Assert.assertNotNull( impl );
			
			//create a null doctype
			var doctype:DocumentType = impl.createDocumentType( null, null, null );
			Assert.assertNotNull( doctype );
			
			//create a plain xml document implementation
			var doc:Document = impl.createDocument( null, "html", doctype );
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );
			
			_document = doc;	
			
			return _document;		
		}
		
		/**
		* 	Test for the error thrown when attempting to
		* 	create an element with an invalid qualified name.
		*/
		[Test(expects="com.ffsys.dom.core.DOMExceptionImpl")]
		public function testInvalidXmlElementName():void
		{
			var doc:Document = getDocument();	
			var elem:Element = doc.createElementNS(
				null, "fluid:button"
					+ String.fromCharCode( 0x037E ) );
		}
		
		[Test]
		public function xmlDocumentCreationTest():void
		{
			var doc:Document = getDocument();	
			
			Assert.assertEquals( "html", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );
			
			//create an element
			var elem:Element = doc.createElement( "head" );
			Assert.assertNotNull( elem );
			
			trace("[GOT XML IMPL] DomTest::xmlDocumentCreationTest()",
				doc, doc.documentElement, doc.documentElement.tagName );
		}
	}
}