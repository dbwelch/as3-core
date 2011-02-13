package org.w3c.xml
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for the XML implementation.
	*/ 
	public class XmlGrammarTest extends Object
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
		*	Creates a <code>XmlGrammarTest</code> instance.
		*/ 
		public function XmlGrammarTest()
		{
			super();
		}
		
		[Test]
		public function xmlNameValid():void
		{
			Assert.assertTrue( XMLGrammar.isValidXMLName( "button" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "fluid:button" ) );
			
			/*
				The character #x037E, GREEK QUESTION MARK, is excluded
				because when normalized it becomes a semicolon,
				which could change the meaning of entity references.
			*/
			Assert.assertFalse(
				XMLGrammar.isValidXMLName( String.fromCharCode( 0x037E ) ) );	
				
			//test start-end character ranges for the NameStartChar product
			Assert.assertTrue( XMLGrammar.isValidXMLName( ":" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "A" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "Z" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "a" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "z" ) );	
			Assert.assertTrue( XMLGrammar.isValidXMLName( "_" ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName( "À" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "Ö" ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName( "Ø" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "ö" ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName( "ø" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "˿" ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName( "Ͱ" ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName( "ͽ" ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x037F ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x1FFF ) ) );

			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x200C ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x200D ) ) );	

			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x2070 ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x218F ) ) );
			
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x2C00 ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x2FEF ) ) );
			
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0x3001 ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0xD7FF ) ) );
			
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0xF900 ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0xFDCF ) ) );
			
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0xFDF0 ) ) );
			Assert.assertTrue( XMLGrammar.isValidXMLName(
				String.fromCharCode( 0xFFFD ) ) );
		}
		
		[Test]
		public function xmlDocumentCreationTest():void
		{
			trace("XmlGrammarTest::xmlDocumentCreationTest()",			
				XMLGrammar.NAME_RE.test( "fluid:button" ),
				XMLGrammar.NAME_RE.test( String.fromCharCode( 0x037E ) ) );
		}
	}
}