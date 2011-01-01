package com.ffsys.ioc
{
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import flash.utils.getQualifiedClassName;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.utils.properties.IProperties;
	
	/**
	*	Unit tests for the bean manager.
	*/ 
	public class BeanManagerTest extends AbstractBeanUnit
	{
		
		/**
		*	The timeout before the load operation fails.
		*/
		private static const TIMEOUT:Number = 30000;
		
		/**
		*	@private
		*/
		private var _beanManager:IBeanManager;
		
		/**
		*	Creates a <code>BeanManagerTest</code> instance.
		*/ 
		public function BeanManagerTest()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_beanManager = new BeanManager();
			_beanManager.document.id = "master";
			addRequests( _beanManager );
			var queue:ILoaderQueue = _beanManager.getLoaderQueue();
			queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBeanManagerAssets, TIMEOUT, null, fail ) );
				
			queue.addEventListener( LoadEvent.DATA, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_START, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_PROGRESS, loadHandler );
			queue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_COMPLETE, loadHandler );
			queue.load();
		}
		
		/**
		* 	@private
		*/
		private function loadHandler( event:LoadEvent ):void
		{
			/*
			trace("BeanManagerTest::loadHandler(), ", event.type, event.uri );
			if( event.type == LoadEvent.DATA )
			{
				if( event.loader is ImageLoader )
				{
					trace("BeanManagerTest::loadHandler() image available: ",
						ImageResource( event.resource ).bitmapData );
				}else if( event.loader is SoundLoader )
				{
					trace("BeanManagerTest::loadHandler() sound available: ",
					 	SoundResource( event.resource ).sound );
				}else if( event.loader is MovieLoader )
				{
					trace("BeanManagerTest::loadHandler() movie available: ",
					 	MovieResource( event.resource ).loader );
				}
			}else if( event.type == LoadEvent.RESOURCE_NOT_FOUND )
			{
				trace("BeanManagerTest::loadHandler() resource not found: ", event.uri );
			}
			*/
		}
		
		[After]
     	public function tearDown():void
		{
			//_beanManager.close = null;
		}
		
		protected function addRequests( manager:IBeanManager ):void
		{
			manager.addBeanDocument( new URLRequest( "mock-beans.css" ) );
		}
		
		protected function assertBeanManagerAssets(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			var document:IBeanDocument = _beanManager.document;
			assertDependenciesBean( document );
			
 			var dependencies:Object = document.getBean( "di-dependencies" );
			Assert.assertNotNull( dependencies );

			Assert.assertTrue( dependencies.propertyBitmap is BitmapData );
			Assert.assertTrue( dependencies.propertySound is Sound );
			Assert.assertTrue( dependencies.propertyMovie is Loader );
			Assert.assertTrue( dependencies.propertyXml is XML );
			Assert.assertTrue( dependencies.propertyText is String );
			Assert.assertTrue( dependencies.propertyFont is Array );
			Assert.assertTrue( dependencies.propertyMessages is IProperties );

			//test the filter declaration
			assertFilterBean( _beanManager.document );
		}
		
		[Test(async)]
		public function mockBeanLoadParseTest():void
		{
			//start the load process
		}
		
		/**
		*	@private	
		*/
		private function fail( event:Event ):void
		{
			throw new Error( "A loader test case timed out." );
		}
	}
}