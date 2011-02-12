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
		/*
		
		XML 1.0 Names and Tokens
		
		[4]   	NameStartChar	   	::=   	":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
		[4a]   	NameChar	   		::=   	NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
		[5]   	Name	   			::=   	NameStartChar (NameChar)*
		[6]   	Names	   			::=   	Name (#x20 Name)*
		[7]   	Nmtoken	   			::=   	(NameChar)+
		[8]   	Nmtokens	   		::=   	Nmtoken (#x20 Nmtoken)*		
		
		*/
		
		/*
		
		XML 1.1 Names and Tokens

		[4]   	NameStartChar	   	::=   	":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
		[4a]   	NameChar	   		::=   	 NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
		[5]   	Name	   			::=   	 NameStartChar (NameChar)*
		[6]   	Names	   			::=   	 Name (#x20 Name)*
		[7]   	Nmtoken	   			::=   	(NameChar)+
		[8]   	Nmtokens	   		::=   	 Nmtoken (#x20 Nmtoken)*
		
		*/
		
		/**
		*	Creates a <code>DomTest</code> instance.
		*/ 
		public function DomTest()
		{
			super();
		}
		
		[Test]
		public function xmlDocumentCreationTest():void
		{
			//XML 1.1
			
			//		A-Za-z_: | À-Ö | Ø-ö | ø-˿ ([#xF8-#x2FF]) | Ͱ-ͽ ([#x370-#x37D]) | Ϳ- ῿ ([#x37F-#x1FFF])
			var nmStartChar:String = "(?:[A-Za-z_:]|[\\xC0-\\xD6]|[\\xD8-\\xF6]|[ø-˿]|[Ͱ-ͽ]"
				+ "|[" + String.fromCharCode( 0x037F ) + "-"
				+ String.fromCharCode( 0x1FFF ) + "]"
				+ "|[" + String.fromCharCode( 0x200C ) + "-"
				+ String.fromCharCode( 0x200D ) + "]"
				+ "|[" + String.fromCharCode( 0x2070 ) + "-"
				+ String.fromCharCode( 0x218F ) + "]"								
				+ "){1}";
			
			/*
			trace("DomTest::xmlDocumentCreationTest()",
				String.fromCharCode( 0xD8 ), "-", String.fromCharCode( 0xF6 ) );
			*/
			
			//Assert.assertTrue( " Ϳ" != " ῿" );
			
			trace("DomTest::xmlDocumentCreationTest()",
				String.fromCharCode( 0x200C ), "-", String.fromCharCode( 0x200D ) );
			
			var nmStartExp:RegExp = new RegExp( nmStartChar );
			
			Assert.assertTrue( nmStartExp.test( ":" ) );
			Assert.assertTrue( nmStartExp.test( "A" ) );
			Assert.assertTrue( nmStartExp.test( "Z" ) );
			Assert.assertTrue( nmStartExp.test( "a" ) );
			Assert.assertTrue( nmStartExp.test( "z" ) );			
			Assert.assertTrue( nmStartExp.test( "_" ) );
			
			Assert.assertTrue( nmStartExp.test( "À" ) );
			Assert.assertTrue( nmStartExp.test( "Ö" ) );
			
			Assert.assertTrue( nmStartExp.test( "Ø" ) );
			Assert.assertTrue( nmStartExp.test( "ö" ) );
			
			Assert.assertTrue( nmStartExp.test( "ø" ) );
			Assert.assertTrue( nmStartExp.test( "˿" ) );
			
			Assert.assertTrue( nmStartExp.test( "Ͱ" ) );
			Assert.assertTrue( nmStartExp.test( "ͽ" ) );
			
			Assert.assertTrue( nmStartExp.test( " Ϳ" ) );
			Assert.assertTrue( nmStartExp.test( " ῿" ) );
			
			Assert.assertTrue( nmStartExp.test( String.fromCharCode( 0x200C ) ) );
			Assert.assertTrue( nmStartExp.test( String.fromCharCode( 0x200D ) ) );	
			
			Assert.assertTrue( nmStartExp.test( String.fromCharCode( 0x2070 ) ) );
			Assert.assertTrue( nmStartExp.test( String.fromCharCode( 0x218F ) ) );					
			
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
			var doc:Document = impl.createDocument( null, "rootElement", doctype );
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );
			
			Assert.assertEquals( "rootElement", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );
			
			trace("[GOT XML IMPL] DomTest::xmlDocumentCreationTest()",
				doc, doc.documentElement, doc.documentElement.tagName );
		}
	}
}