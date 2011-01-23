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
				
			//add a custom namespace
			document.namespaceDeclarations.push( 
				new Namespace( "xml", "http://www.w3.org/XML/1998/namespace" ) );
				
			//add a qualified attribute
			document.setAttributeNS( "http://www.w3.org/XML/1998/namespace", "lang", "en" );
			
			trace("DomBuildTest::domBuildTest()", document.xml.toXMLString() );
		}
	}
}