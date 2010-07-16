package com.ffsys.io.loaders.types {
	
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	
	import com.ffsys.io.loaders.AbstractLoaderUnit;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.utils.properties.IProperties;
	import com.ffsys.utils.properties.Properties;
	
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
			
			var properties:Properties = Properties(
				PropertiesResource( event.resource ).properties );
			Assert.assertTrue( properties is IProperties );
			
			Assert.assertEquals( "a test top level string", properties.toplevel );
			Assert.assertEquals( "abc", properties.group.a );
			Assert.assertEquals( "bcd", properties.group.b );
			
			Assert.assertEquals( "abcdef", properties.group.nested.a );
			Assert.assertEquals( "bcdefg", properties.group.nested.b );	
			
			Assert.assertTrue( properties.group is IProperties );
			Assert.assertTrue( properties.group.nested is IProperties );
			Assert.assertTrue(
				properties.getPropertiesById( "group" ) is IProperties );
			
			//
			Assert.assertEquals(
				"An error of type {0} occured", properties.group.err );
			
			//	
			Assert.assertEquals(
				"An error of type critical occured", properties.group.substitute(
					"err", [ "critical" ] ) );			
		}
		
		[Test(async)]
		public function loadFile():void
		{
			//start the load process
		}
	}
}