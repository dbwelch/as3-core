package com.ffsys.io.xml
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.ObjectResource;
	import com.ffsys.io.xml.parsers.PrimitiveParser;
	
	/**
	*	Unit tests for loading and deserializing an XML document
	*	to primitive values.
	*	
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class PrimitiveDocumentTest extends AbstractXmlLoadUnit
	{
		/**
		* 	Creats a <code>PrimitiveDocumentTest</code> instance.
		*/
		public function PrimitiveDocumentTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getXmlParser():IParser
		{
			return new PrimitiveParser();			
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getXmlLoadPath():String
		{
			return "mock-primitive-document.xml";
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function assertLoadedDocument(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			
			/*
			trace("PrimitiveDocumentTest::assertLoadedDocument(), ",
				event, event.resource );
				
			trace("PrimitiveDocumentTest::assertLoadedDocument(), ",
				( event.resource is ObjectResource ) );
			*/	
			
			Assert.assertNotNull( event.resource );
			Assert.assertTrue( ( event.resource is ObjectResource ) );
			
			var resource:ObjectResource = ObjectResource( event.resource );
			
			Assert.assertTrue( resource.data is Object );
			Assert.assertEquals( "this is a test string", resource.data.string );
			Assert.assertTrue( resource.data.booleanTrue );
			Assert.assertFalse( resource.data.booleanFalse );
			Assert.assertNull( resource.data.nullValue );
			Assert.assertEquals( 10, resource.data.integerValue );
			Assert.assertTrue( resource.data.integerValue is int );
			Assert.assertEquals( 1.67, resource.data.floatValue );
			Assert.assertTrue( resource.data.floatValue is Number );
			
			Assert.assertEquals( 100, resource.data.hyphenTest );
						
			//trace("PrimitiveDocumentTest::assertLoadedDocument(), ", resource.data.floatValue );
		}
	
		[Test(async)]
		public function loadPrimitivesDocument():void
		{
			//
		}
	}
}