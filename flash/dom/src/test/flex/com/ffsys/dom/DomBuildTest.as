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
		
		protected function assertDocumentCreationMethods( document:Document ):void
		{
			//assertions on the creation methods
			var txt:Text = document.createTextNode( "this is some text" );
			Assert.assertTrue( txt is Text );
			Assert.assertEquals( Node.TEXT_NODE, txt.nodeType );
			
			var cdata:CDATASection = document.createCDATASection( "this is some cdata text" );
			Assert.assertTrue( cdata is CDATASection );
			Assert.assertEquals( Node.CDATA_SECTION_NODE, cdata.nodeType );
			
			var attr:Attr = document.createAttribute( "id" );
			Assert.assertTrue( attr is Attr );
			Assert.assertEquals( Node.ATTRIBUTE_NODE, attr.nodeType );
						
			Assert.assertEquals( "id", attr.name );
			Assert.assertEquals( "id", attr.nodeName );
			Assert.assertEquals( "id", attr.localName );
			
			//can't assert on an attribute prefix until it has an owner element
			attr = document.createAttributeNS( "http://www.w3.org/XML/1998/namespace", "lang" );
			Assert.assertTrue( attr is Attr );
			Assert.assertEquals( Node.ATTRIBUTE_NODE, attr.nodeType );
			Assert.assertEquals( "lang", attr.name );
			Assert.assertEquals( "lang", attr.localName );
			Assert.assertEquals( "http://www.w3.org/XML/1998/namespace", attr.uri );			
			
			var comment:Comment = document.createComment( "This is a comment" );
			Assert.assertTrue( comment is Comment );
			Assert.assertEquals( Node.COMMENT_NODE, comment.nodeType );
			
			var instruction:ProcessingInstruction =
				document.createProcessingInstruction( "flash", "flash-dom-exclude" );
			Assert.assertTrue( instruction is ProcessingInstruction );
			Assert.assertEquals(
				Node.PROCESSING_INSTRUCTION_NODE, instruction.nodeType );
				
			var fragment:DocumentFragment = document.createDocumentFragment();
			Assert.assertTrue( fragment is DocumentFragment );
			Assert.assertEquals(
				Node.DOCUMENT_FRAGMENT_NODE, fragment.nodeType );
				
			var elem:Element = document.createElement( DomIdentifiers.ANCHOR );
			Assert.assertTrue( elem is AnchorElement );
			Assert.assertEquals(
				Node.ELEMENT_NODE, elem.nodeType );	
				
			elem = document.createElementNS(
				"http://www.w3.org/1999/xhtml", DomIdentifiers.ANCHOR );
			Assert.assertTrue( elem is AnchorElement );
			Assert.assertEquals(
				Node.ELEMENT_NODE, elem.nodeType );	
			Assert.assertEquals(
				"http://www.w3.org/1999/xhtml", elem.namespaceURI );
				
			//TODO: implement
			//createEntityReference
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
			
			//add a custom namespace
			document.namespaceDeclarations.push( 
				new Namespace( "xml", "http://www.w3.org/XML/1998/namespace" ) );

			//default xmlns and xmlns:xml are at the document level
			Assert.assertEquals( 2, document.namespaceDeclarations.length );
				
			assertDocumentCreationMethods( document );
				
			//manually bind the DOM for $ access
			Assert.assertTrue( ActionscriptQuery.bind( document ) );
				
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
			Assert.assertTrue( document.head is Head );
			
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
			
			//create and add a body element
			var body:Element = document.createElement( DomIdentifiers.BODY );
			body.setAttribute( "style", "background-color: #0000ff;" );
			document.appendChild( body );
			Assert.assertEquals( 2, document.childNodes.length );
			Assert.assertNotNull( document.body );
			Assert.assertTrue( document.body is Body );
			
			//check top-level attributes at the document level
			Assert.assertEquals( "http://www.w3.org/1999/xhtml", document.xmlns );
			Assert.assertEquals( "en", document.lang );
			
			//check top-level attributes are inherited from the document when not specified
			Assert.assertEquals( "http://www.w3.org/1999/xhtml", document.head.xmlns );
			Assert.assertEquals( "en", document.head.lang );
			
			//verify explicity set xmlns/xsi/lang
			document.head.xmlns = "http://freeformsystems.com/fluid/ui";
			document.head.xsi = "http://freeformsystems.com/fluid/ui/schema";
			document.head.lang = "fr";
			
			Assert.assertEquals( "http://freeformsystems.com/fluid/ui", document.head.xmlns );
			Assert.assertEquals( "http://freeformsystems.com/fluid/ui/schema", document.head.xsi );
			Assert.assertEquals( "fr", document.head.lang );
				
			//verify basic previous/next sibling
			Assert.assertEquals( document.body, document.head.nextSibling );
			Assert.assertEquals( document.head, document.body.previousSibling );
			Assert.assertNull( document.head.previousSibling );
			Assert.assertNull( document.body.nextSibling );
			
			trace("DomBuildTest::domBuildTest()", document.title, document.xml.toXMLString() );
			
			//unbind the DOM for $ access
			Assert.assertTrue( ActionscriptQuery.unbind( document ) );
		}
	}
}