package com.ffsys.io.loaders.core {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	A simple test for verifying that nested loader queues behave as expected.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.10.2010
	*/
	public class TreeLoaderQueueTest extends Object {
		
		/**
		*	The timeout before the load operation fails.
		*/
		public static const TIMEOUT:Number = 60000;
		
		/**
		*	@private	
		*/
		private var _queue:ILoaderQueue;
		
		/**
		*	Creates an <code>TreeLoaderQueueTest</code> instance.	
		*/
		public function TreeLoaderQueueTest()
		{
			super();
		}
		
		/**
		*	Gets the loader used for the test.	
		*/
		protected function getLoaderQueue():ILoaderQueue
		{
			return new LoaderQueue();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			var loader:ILoader = null;
			_queue = getLoaderQueue();
			_queue.id = "main";
			_queue.customData = "main-queue";
			
			//top-level loader
			loader = new BinaryLoader( new URLRequest( "assets/test.osc" ) );
			_queue.addLoader( loader );
			
			//nested queue
			var nested:ILoaderQueue = new LoaderQueue();
			nested.id = "nested";
			nested.customData = "nested-queue";
			
			loader = new ImageLoader( new URLRequest( "assets/test.jpg" ) );
			nested.addLoader( loader );
			
			//nested another level
			var child:ILoaderQueue = new LoaderQueue();
			child.id = "child";
			child.customData = "child-queue";
			
			loader = new XmlLoader( new URLRequest( "assets/test.xml" ) );
			child.addLoader( loader );
			nested.addLoader( child );
			_queue.addLoader( nested );
			
			//sibling to the initial nested queue
			var sibling:ILoaderQueue = new LoaderQueue();
			sibling.id = "sibling";	
			sibling.customData = "sibling-queue";
			
			loader = new ImageLoader( new URLRequest( "assets/test.jpg" ) );
			sibling.addLoader( loader );
			
			loader = new MovieLoader( new URLRequest( "assets/test.swf" ) );
			sibling.addLoader( loader );	
			
			loader = new PropertiesLoader( new URLRequest( "assets/test.properties" ) );
			sibling.addLoader( loader );
			
			_queue.addLoader( sibling );
			
			/*
			
			loader = new SoundLoader( new URLRequest( "assets/test.mp3" ) );
			_queue.addLoader( loader );
			
			loader = new StyleSheetLoader( new URLRequest( "assets/test.css" ) );
			_queue.addLoader( loader );
			
			loader = new TextLoader( new URLRequest( "assets/test.txt" ) );
			_queue.addLoader( loader );
			
			loader = new VariableLoader( new URLRequest( "assets/test.variables" ) );
			_queue.addLoader( loader );
			
			loader = new VideoLoader( new URLRequest( "assets/test.flv" ) );
			_queue.addLoader( loader );
			
			loader = new XmlLoader( new URLRequest( "assets/test.xml" ) );
			_queue.addLoader( loader );
			*/
			
			_queue.addEventListener(
				LoadEvent.LOAD_START,
				loadStart );		
				
			_queue.addEventListener(
				LoadEvent.LOAD_PROGRESS,
				loadProgress );
				
			_queue.addEventListener(
				LoadEvent.DATA,
				loaded );
			
			_queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertLoadedAsset, TIMEOUT, null, fail ) );
			_queue.load();
		}
		
		[After]
     	public function tearDown():void
		{
			_queue = null;
		}
		
		/**
		*	@private
		*/
		protected function loadStart(
			event:LoadEvent ):void
		{
			trace("TreeLoaderQueueTest::loadStart()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loadProgress(
			event:LoadEvent ):void
		{
			trace("TreeLoaderQueueTest::loadProgress()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loaded(
			event:LoadEvent ):void
		{
			trace("TreeLoaderQueueTest::loaded()", event, event.type, event.uri );
		}
		
		/**
		*	Performs assertions when the asset is loaded.
		*	
		*	@param event The event that loaded the asset.
		*	@param passThroughData The custom pass through data.
		*/
		protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			trace("TreeLoaderQueueTest::assertLoadedAsset()", "CHECKING ASSERTIONS ON QUEUE", _queue );
			
			Assert.assertNotNull( _queue.resources );
			Assert.assertTrue( _queue.resources is IResourceList );
			Assert.assertEquals( 3, _queue.resources.length );
			Assert.assertTrue( _queue.resources.getResourceAt( 0 ) is BinaryResource );
			
			//image loader in the initial nested queue
			var list:Object = _queue.resources.getResourceAt( 1 );
			Assert.assertTrue( list is IResourceList );
			var nested:IResourceList = IResourceList( list );
			Assert.assertTrue( nested.getResourceAt( 0 ) is ImageResource );
			
			//dig down to the next nested level
			list = nested.getResourceAt( 1 );
			Assert.assertTrue( list is IResourceList );
			var child:IResourceList = IResourceList( list );
			Assert.assertNotNull( child );
			
			Assert.assertTrue( child.getResourceAt( 0 ) is XmlResource );
			
			/*
			var fonts:Object = ObjectResource( child.getResourceAt( 0 ) ).data;
			Assert.assertTrue( fonts is Array );
			Assert.assertEquals( 1, ( fonts as Array ).length );
			Assert.assertTrue( fonts[ 0 ] is Font );
			*/
		}
		
		/**
		*	@private	
		*/
		private function fail( event:Event ):void
		{
			throw new Error( "A loader test case timed out." );
		}
		
		[Test(async)]
		public function testTreeLoaderQueue():void
		{
			//start the load process
		}				
	}
}