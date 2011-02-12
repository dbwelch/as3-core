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
		/**
		*	Creates a <code>DomTest</code> instance.
		*/ 
		public function DomTest()
		{
			super();
		}
		
		[Test]
		public function documentCreationTest():void
		{
			//bean document for bootstrap classes
			var beans:IBeanDocument = new DOMBootstrap();
			
			var registry:DOMImplementationRegistry = DOMImplementationRegistry(
				beans.getBean( DOMBootstrap.DOM_REGISTRY ) );
				
			Assert.assertNotNull( registry );
			
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.XML_MODULE + " 3.0" );
				
			trace("[GOT XML IMPL] DomTest::documentCreationTest()", impl );
				
			//var doc:Document = new DocumentImpl();
		}
	}
}