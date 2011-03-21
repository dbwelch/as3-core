package org.flashx.io.loaders {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.types.*;
	
	/**
	*	Abstract super class for unit tests that load
	*	a single runtime asset.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class AbstractLoaderUnit extends Object {
		
		/**
		*	The timeout before the load operation fails.
		*/
		public static const TIMEOUT:Number = 5000;
		
		/**
		*	@private	
		*/
		protected var _loader:ILoader;
		
		/**
		*	Creates an <code>AbstractLoaderUnit</code> instance.	
		*/
		public function AbstractLoaderUnit()
		{
			super();
		}
		
		/**
		*	Gets the loader used for the test.	
		*/
		protected function getLoader():ILoader
		{
			throw new Error(
				"You must supply the loader implementation in your concrete unit test." );
		}
		
		/**
		*	Gets the request used to perform the loading of the asset.
		*/
		protected function getLoadRequest():URLRequest
		{
			throw new Error(
				"You must supply the load request in your concrete unit test." );
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_loader = getLoader();
			_loader.request = getLoadRequest();
			_loader.addEventListener(
				LoadEvent.LOAD_FINISHED,
				Async.asyncHandler( this, assertLoadedAsset, TIMEOUT, null, fail ) );
			_loader.load();
		}
		
		[After]
     	public function tearDown():void
		{
			_loader = null;
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
			//
		}
		
		/**
		*	@private	
		*/
		protected function fail( event:Event ):void
		{
			throw new Error( "A loader test case timed out." );
		}		
	}
}