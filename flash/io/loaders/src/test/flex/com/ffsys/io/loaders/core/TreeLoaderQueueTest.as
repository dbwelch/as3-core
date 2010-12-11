package com.ffsys.io.loaders.core {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
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
			
			loader = new BinaryLoader( new URLRequest( "assets/test.osc" ) );
			_queue.addLoader( loader );
			
			var nested:ILoaderQueue = new LoaderQueue();
			
			loader = new ImageLoader( new URLRequest( "assets/test.jpg" ) );
			nested.addLoader( loader );
			_queue.addLoader( nested );
			
			/*
			
			loader = new FontLoader( new URLRequest( "assets/test-fonts.swf" ) );
			_queue.addLoader( loader );			
			
			loader = new ImageLoader( new URLRequest( "assets/test.jpg" ) );
			_queue.addLoader( loader );
			
			loader = new MovieLoader( new URLRequest( "assets/test.swf" ) );
			_queue.addLoader( loader );	
			
			loader = new PropertiesLoader( new URLRequest( "assets/test.properties" ) );
			_queue.addLoader( loader );
			
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
		*	Performs assertions when the asset is loaded.
		*	
		*	@param event The event that loaded the asset.
		*	@param passThroughData The custom pass through data.
		*/
		protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			Assert.assertNotNull( _queue.resources );
			Assert.assertTrue( _queue.resources is IResourceList );
			Assert.assertEquals( 2, _queue.resources.length );
			Assert.assertTrue( _queue.resources.getResourceAt( 0 ) is IResource );
			
			var list:Object = _queue.resources.getResourceAt( 1 );
			Assert.assertTrue( list is IResourceList );
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