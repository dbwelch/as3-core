package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	/**
	*	Unit test for handling resource not found events for
	* 	style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.10.2010
	*/
	public class StyleSheetResourceNotFoundTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>StyleSheetResourceNotFoundTest</code> instance.
		*/
		public function StyleSheetResourceNotFoundTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new StyleSheetLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test-resource-not-found.css" );
		}
		
		[Before( async )]
     	override public function setUp():void
		{
			_loader = getLoader();
			_loader.addEventListener(
				LoadEvent.RESOURCE_NOT_FOUND,
				Async.asyncHandler( this, assertLoadedAsset, TIMEOUT, null, fail ) );
			_loader.load( getLoadRequest() );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			Assert.assertEquals( "assets/test-resource-not-found.css", event.uri );
			Assert.assertEquals( LoadEvent.RESOURCE_NOT_FOUND, event.type );
			Assert.assertTrue( event.loader is StyleSheetLoader );
			Assert.assertNull( event.resource );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}