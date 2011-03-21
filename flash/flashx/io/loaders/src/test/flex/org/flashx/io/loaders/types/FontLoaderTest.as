package org.flashx.io.loaders.types {
	
	import flash.net.URLRequest;
	import flash.text.Font;
	
	import org.flexunit.Assert;
	
	import org.flashx.io.loaders.AbstractLoaderUnit;

	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
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
			Assert.assertTrue( event.resource is ObjectResource );
			
			var fonts:Array = Font.enumerateFonts();
			Assert.assertTrue( fonts.length > 0 );
			
			//font loaders create an object resource containing the
			//registered fonts in an array
			var data:Object = ObjectResource( event.resource ).data;
			Assert.assertTrue( data is Array );
			
			var registered:Array = ( data as Array );
			Assert.assertEquals( 1, registered.length );
			Assert.assertTrue( registered[ 0 ] is Font );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}