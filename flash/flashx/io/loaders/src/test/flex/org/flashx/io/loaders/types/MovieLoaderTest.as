package org.flashx.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import org.flashx.io.loaders.AbstractLoaderUnit;

	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	/**
	*	Unit test for loading swf files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class MovieLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>MovieLoaderTest</code> instance.
		*/
		public function MovieLoaderTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new MovieLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.swf" );
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
			Assert.assertTrue( event.resource is MovieResource );
			//Assert.assertTrue( MovieResource( event.resource ).bytesTotal > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}