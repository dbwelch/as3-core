package com.ffsys.w3c.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.ioc.*;
	import com.ffsys.w3c.dom.*;
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class DomTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomTest</code> instance.
		*/ 
		public function DomTest()
		{
			super();
		}
		
		/**
		* 	Test for the error thrown when attempting to call
		* 	createElementNS() with an invalid qualified name.
		*/
		[Test(expects="org.w3c.dom.DOMException")]
		public function testInvalidXmlElementNameCreateElementNS():void
		{
			var doc:Document = getXMLDocument();	
			var elem:Element = doc.createElementNS(
				null, "fluid:button"
					+ String.fromCharCode( 0x037E ) );
		}
		
		/**
		* 	Test for the error thrown when attempting to call
		* 	createElement() with an invalid tag name.
		*/
		[Test(expects="org.w3c.dom.DOMException")]
		public function testInvalidXmlElementNameCreateElement():void
		{
			var doc:Document = getXMLDocument();	
			var elem:Element = doc.createElement(
				"button" + String.fromCharCode( 0x037E ) );
		}
		
		[Test]
		public function testCreateElement():void
		{
			var doc:Document = getXMLDocument();	
			
			//create an element
			var elem:Element = doc.createElement( "head" );
			Assert.assertNotNull( elem );
			//Assert.assertEquals( "head", elem.nodeName );
			//Assert.assertNull( elem.localName );
			Assert.assertNull( elem.namespaceURI );
			Assert.assertNull( elem.prefix );
		}
	}
}