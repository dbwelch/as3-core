package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.utils.properties.IProperties;
	
	/**
	*	Unit test for loading properties files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public class PropertiesLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>PropertiesLoaderTest</code> instance.
		*/
		public function PropertiesLoaderTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoader():ILoader
		{
			return new PropertiesLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.properties" );
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
			Assert.assertTrue( event.resource is PropertiesResource );
			
			Assert.assertTrue(
				PropertiesResource( event.resource ).properties is IProperties );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}