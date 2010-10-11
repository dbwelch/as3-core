package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	import flash.text.Font;
	
	import org.flexunit.Assert;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	/**
	*	Unit test for loading swf font files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class FontLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>FontLoaderTest</code> instance.
		*/
		public function FontLoaderTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new FontLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test-fonts.swf" );
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
			Assert.assertTrue( event.resource is FontResource );
			
			var fonts:Array = Font.enumerateFonts();
			Assert.assertTrue( fonts.length > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}