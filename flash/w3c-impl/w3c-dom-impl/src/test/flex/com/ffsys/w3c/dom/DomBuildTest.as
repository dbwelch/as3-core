package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.*;
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
	
	/**
	*	Unit tests for manually constructing DOM hierarchies.
	*/ 
	public class DomBuildTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomBuildTest</code> instance.
		*/ 
		public function DomBuildTest()
		{
			super();
		}
		
		[Test]
		public function testBuildDom():void
		{
			var doc:Document = getXMLDocument();
			var el:Element = doc.documentElement;
			Assert.assertNotNull( el );
			
			var nm:String = "graphics";
			
			//rename the root element
			doc.renameNode( el, null, nm );
			
			Assert.assertEquals( nm, el.tagName );
			Assert.assertEquals( nm, el.nodeName );
			
			//now try to rename to a fully qualified name
			doc.renameNode( el, "http://example.org/graphics", "example:graphics" );
			
			trace("[DOM BUILD TEST] DomBuildTest::testBuildDom()", el, el.tagName );
			trace( NodeImpl( doc ).xml.toXMLString() );
		}
	}
}