package com.ffsys.di
{
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import flash.utils.getQualifiedClassName;
	
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
			var queue:ILoaderQueue = _beanManager.load();
			queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBeanFileDependencyAssets, TIMEOUT, null, fail ) );
				
			queue.addEventListener( LoadEvent.DATA, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_START, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_PROGRESS, loadHandler );
			queue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_COMPLETE, loadHandler );
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