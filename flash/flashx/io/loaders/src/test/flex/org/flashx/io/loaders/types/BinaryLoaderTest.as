package org.flashx.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import org.flashx.io.loaders.AbstractLoaderUnit;

	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	/**
	*	Unit test for loading binary files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class BinaryLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>BinaryLoaderTest</code> instance.
		*/
		public function BinaryLoaderTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new BinaryLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.osc" );
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
			Assert.assertTrue( event.resource is BinaryResource );
			//Assert.assertTrue( BinaryResource( event.resource ).bytesTotal > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}