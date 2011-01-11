package com.ffsys.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import asquery.$;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class SimpleDOMTest extends Object
	{
		/**
		*	Creates a <code>SimpleDOMTest</code> instance.
		*/ 
		public function SimpleDOMTest()
		{
			super();
			XML.ignoreComments = false;
			XML.ignoreProcessingInstructions = false;
			XML.ignoreWhitespace = false;
			XML.prettyIndent = 0;
			XML.prettyPrinting = false;					
		}
		
		public function get sample():XML
		{
			return <object
				id="root"
				xmlns="http://example.com/sample"
				xmlns:ui="http://example.com/nested-sample">
				text
	            <!-- comment -->
	            <?instruction ?>
				<string>
					this is a <em>test</em> string
				</string>
				<booleanTrue>true</booleanTrue>
				<booleanFalse>false</booleanFalse>
				<nullValue>null</nullValue>
				<integerValue>10</integerValue>
				<floatValue>1.67</floatValue>
				<hyphen-test>100</hyphen-test>
				<nested id="my-identifier">
					<child><![CDATA[This is some character data]]></child>
					<ui:button />
				</nested>
			</object>;
		}
		
		/*
		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
		    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">		
		
		*/
		
		[Test]
		public function domTest():void
		{
			var impl:DOMImplementation = new DOMImplementation();
			var type:DocumentType = impl.getXhtmlDocumentType();
			var document:Document = impl.createDocument( "http://www.w3.org/1999/xhtml", "html", type );
			
			trace("SimpleDOMTest::domTest()", document, document.head, document.body );
			
			//trace( $( ".links" ) );
		}
	}
}