package com.ffsys.ioc
{
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.media.*;
	import flash.text.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.utils.properties.IProperties;	
	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.ioc.mock.*;
	
	/**
	*	Unit tests for <code>BeanDependencyLoadTest</code>.
	*/ 
	public class BeanDependencyLoadTest extends AbstractBeanUnit
	{
		private var _rectangle:RectangleGraphic;
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;
		
		/**
		*	The timeout before the load operation fails.
		*/
		private static const TIMEOUT:Number = 30000;
		
		/**
		*	@private	
		*/
		private var _beanManager:IBeanManager;
		
		/**
		*	Creates a <code>BeanDependencyLoadTest</code> instance.
		*/ 
		public function BeanDependencyLoadTest()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_beanManager = new BeanManager();
			addRequests( _beanManager );
			var queue:ILoaderQueue = _beanManager.getLoaderQueue();
			queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBeanFileDependencyAssets, TIMEOUT, null, fail ) );
				
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
			trace("BeanDependencyLoadTest::loadHandler(), ", event.type, event.uri );
			if( event.type == LoadEvent.DATA )
			{
				if( event.loader is ImageLoader )
				{
					trace("BeanDependencyLoadTest::loadHandler() image available: ",
						ImageResource( event.resource ).bitmapData );
				}else if( event.loader is SoundLoader )
				{
					trace("BeanDependencyLoadTest::loadHandler() sound available: ",
					 	SoundResource( event.resource ).sound );
				}else if( event.loader is MovieLoader )
				{
					trace("BeanDependencyLoadTest::loadHandler() movie available: ",
					 	MovieResource( event.resource ).loader );
				}else if( event.loader is XmlLoader )
				{
					trace("BeanDependencyLoadTest::loadHandler() xml available: ",
					 	XmlResource( event.resource ).xml );
				}
			}else if( event.type == LoadEvent.RESOURCE_NOT_FOUND )
			{
				trace("BeanDependencyLoadTest::loadHandler() resource not found: ", event.uri );
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
		
		protected function assertBeanFileDependencyAssets(
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
			Assert.assertTrue( dependencies.propertySettings is IProperties );
			
			//TODO: assertions on the loaded settings values
			var settings:Object = Object( dependencies.propertySettings );
			Assert.assertEquals( "3d", settings.application.mode );
			Assert.assertFalse( settings.application.launch.enabled );
			Assert.assertTrue( settings.application.login.enabled );
			Assert.assertEquals( 512, settings.application.connections.maximum );
			Assert.assertTrue( settings.application.sections.disabled is Array );

			//assertions on the contents of loaded files
			Assert.assertEquals( "hello xml world",
				dependencies.propertyXml.text()[ 0 ] );
			Assert.assertEquals( "hello text world",
				dependencies.propertyText );
			Assert.assertEquals( "hello properties world",
				dependencies.propertyMessages.getProperty( "message" ) );
			
			//basic assertions on the loaded font data
			var fonts:Array = ( dependencies.propertyFont as Array );
			Assert.assertEquals( 1, fonts.length );
			Assert.assertTrue( fonts[ 0 ] is Font );
			
			//check file dependecies declared to load when a bean is retrieved
			var lazilyLoaded:Object = document.getBean( "bean-dependencies" );
			Assert.assertNotNull( lazilyLoaded );
			
			Assert.assertTrue( lazilyLoaded is MockFileLoaderBean );
			var loader:MockFileLoaderBean = MockFileLoaderBean( lazilyLoaded );
			
			//chain an async for loading the resources upon bean retrievel
			loader.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBeanLoaderDependencies, TIMEOUT, loader, fail ) );
		}
		
		protected function assertBeanLoaderDependencies(
			event:LoadEvent,
			passThroughData:Object ):void		
		{
			Assert.assertTrue( passThroughData is MockFileLoaderBean );
			var loader:MockFileLoaderBean = MockFileLoaderBean( passThroughData );
			
			//the total number of expected resources
			var total:Number = 8;
			
			Assert.assertNotNull( loader.propertyBitmap );
			Assert.assertNotNull( loader.propertySound );
			Assert.assertNotNull( loader.propertyMovie );
			Assert.assertNotNull( loader.propertyXml );
			Assert.assertNotNull( loader.propertyText );
			Assert.assertNotNull( loader.propertyFont );
			Assert.assertNotNull( loader.propertyMessages );
			Assert.assertNotNull( loader.propertySettings );
			
			//verify observer methods fired
			Assert.assertTrue( loader.autoLoad );
			Assert.assertNotNull( loader.targetResources );
			Assert.assertNotNull( loader.queue );
			//the bean is the loader queue implementation in this case
			Assert.assertEquals( loader, loader.targetQueue );			
			Assert.assertEquals( total, loader.targetResources.length );
			Assert.assertEquals( total, loader.loadedResources.length );
		}
		
		[Test(async)]
		public function beanDependencyLoadTest():void
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