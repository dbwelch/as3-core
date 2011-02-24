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
	import org.w3c.dom.bootstrap.DOMImplementationRegistry;
	
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
			var doc:Document = getHTMLDocument();
			
			var el:Element = doc.documentElement;
			
			trace("[DOM BUILD TEST] DomBuildTest::testBuildDom()", el );
			
			//create an element
			//var elem:Element = doc.createElement( "head" );
			//doc.documentElement.appendChild( elem );
		}
	}
}