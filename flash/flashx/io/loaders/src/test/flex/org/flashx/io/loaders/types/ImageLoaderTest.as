package org.flashx.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import org.flashx.io.loaders.AbstractLoaderUnit;

	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	/**
	*	Unit test for loading image files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class ImageLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>ImageLoaderTest</code> instance.
		*/
		public function ImageLoaderTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new ImageLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.jpg" );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			Assert.assertTrue(
				event is LoadEvent );
			Assert.assertNotNull( event.resource );	
			Assert.assertTrue( event.resource is ImageResource );
			//Assert.assertTrue( ImageResource( event.resource ).bytesTotal > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}