package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	/**
	*	Unit test for loading binary files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class VariableLoaderTest extends AbstractLoaderUnit {
		
		/**
		*	Creates a <code>VariableLoaderTest</code> instance.
		*/
		public function VariableLoaderTest()
		{
			super();
		}
		
		/**
		*	Gets the loader used for the test.
		*/
		override protected function getLoader():ILoader
		{
			return new VariableLoader();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "assets/test.variables" );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			Assert.assertTrue(
				event is VariableLoadEvent );
			Assert.assertNotNull( event.resource );	
			Assert.assertTrue( event.resource is VariableResource );
			//Assert.assertTrue( VariableResource( event.resource ).bytesTotal > 0 );
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}