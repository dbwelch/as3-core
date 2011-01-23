package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.dom.xhtml.*;
	
	/**
	*	Unit tests for manually building <code>DOM</code> structures.
	*/ 
	dynamic public class DomBuildTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomBuildTest</code> instance.
		*/ 
		public function DomBuildTest()
		{
			super();		
		}		
		
		[Test]
		public function domBuildTest():void
		{	
			//create an implementation
			impl = new DOMImplementation();
			
			var doctype:DocumentType = impl.createDocumentType(
				DomIdentifiers.DOCUMENT,
				"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd",
				"-//W3C//DTD XHTML Basic 1.1//EN" );
			
			document = impl.createDocument(
				"http://www.w3.org/1999/xhtml", DomIdentifiers.DOCUMENT, doctype );
				
			//manually bind the DOM for $ access
			Assert.assertTrue( ActionscriptQuery.bind( document ) );
				
			//add a custom namespace
			document.namespaceDeclarations.push( 
				new Namespace( "xml", "http://www.w3.org/XML/1998/namespace" ) );
				
			//default xmlns and xmlns:xml are at the document level
			Assert.assertEquals( 2, document.namespaceDeclarations.length );
				
			//add a qualified attribute
			document.setAttributeNS(
				"http://www.w3.org/XML/1998/namespace",
				"lang",
				"en" );
				
			//add a plain attribute
			document.setAttribute(
				"lang",
				"en" );
				
			//add an id attribute
			document.setAttribute(
				"id",
				"document" );
				
			//should only have the custom attributes registered
			//not any xmlns attributes
			Assert.assertEquals( 3, document.attributes.length );
				
			//create and add a head element
			var head:Element = document.createElement( DomIdentifiers.HEAD );
			document.appendChild( head );
			Assert.assertEquals( 1, document.childNodes.length );
			
			Assert.assertNotNull( document.head );
			
			//create and add the title
			var title:Element = document.createElement(
				DomIdentifiers.TITLE );
			title.text( "This is a page title" );
			head.appendChild( title );
			
			Assert.assertEquals( "This is a page title", title.text() );
			Assert.assertEquals( "This is a page title", document.title );
			
			//verify changing the page title
			document.title = "This is a new page title";
			Assert.assertEquals( "This is a new page title", title.text() );
			Assert.assertEquals( "This is a new page title", document.title );
			
			trace("DomBuildTest::domBuildTest()", document.title, document.xml.toXMLString() );
			
			//unbind the DOM for $ access
			Assert.assertTrue( ActionscriptQuery.unbind( document ) );
		}
	}
}