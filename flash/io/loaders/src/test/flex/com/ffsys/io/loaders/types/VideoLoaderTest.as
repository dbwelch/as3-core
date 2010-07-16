package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	/**
	*	Unit test for loading video files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class VideoLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>VideoLoaderTest</code> instance.
		*/
		public function VideoLoaderTest()
		{
			super();
		}
		
		/**
		*	Gets the loader used for the test.
		*/
		override protected function getLoader():ILoader
		{
			return new VideoLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.flv" );
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
			Assert.assertTrue( event.resource is VideoResource );
			//Assert.assertTrue( VideoResource( event.resource ).bytesTotal > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}