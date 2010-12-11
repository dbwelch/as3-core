package com.ffsys.di
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Unit tests for the bean manager.
	*/ 
	public class BeanManagerTest extends AbstractBeanUnit
	{
		private var _rectangle:RectangleGraphic;
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;
		
		/**
		*	The timeout before the load operation fails.
		*/
		private static const TIMEOUT:Number = 10000;
		
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
			addRequests( _beanManager );
			var queue:ILoaderQueue = _beanManager.load();
			queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBeanManagerAssets, TIMEOUT, null, fail ) );
				
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
		}
		
		[After]
     	public function tearDown():void
		{
			//_beanManager.close = null;
		}
		
		protected function addRequests( manager:IBeanManager ):void
		{
			manager.addBeanDocument( null, new URLRequest( "mock-beans.css" ) );
		}
		
		protected function assertBeanManagerAssets(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			//TODO: assertions
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