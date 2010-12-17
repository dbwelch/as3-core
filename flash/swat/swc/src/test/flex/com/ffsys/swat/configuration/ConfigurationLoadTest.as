package com.ffsys.swat.configuration
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.swat.AbstractUnit;
	
	import com.ffsys.swat.events.*;
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.swat.configuration.rsls.*;
	
	/**
	*	Unit tests for ensuring the configuration data can
	* 	be loaded and parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class ConfigurationLoadTest extends AbstractUnit
	{
		
		/**
		* 	Creats a <code>ConfigurationLoadTest</code> instance.
		*/
		public function ConfigurationLoadTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function assertLoadedConfiguration(
			event:ConfigurationEvent,
			passThroughData:Object ):void
		{
			super.assertLoadedConfiguration( event, passThroughData );

			var configuration:IConfiguration = event.configuration;
			
			trace("ConfigurationLoadTest::assertLoadedConfiguration()",  configuration);			
			
			Assert.assertNotNull( configuration );
			Assert.assertNotNull( configuration.locales );
			Assert.assertNotNull( configuration.locales.resources );
			
			//test parent references are correct
			Assert.assertNotNull( configuration.locales.parent );
			Assert.assertEquals( configuration, configuration.locales.parent );
			Assert.assertEquals( 4, configuration.locales.length );
			
			var locales:Array = configuration.locales.getLocales();
			
			Assert.assertEquals( 4, locales.length );
			
			var locale:IConfigurationLocale = IConfigurationLocale( locales[ 0 ] );
			Assert.assertNotNull( locale );
			Assert.assertNotNull( locale.parent );
			Assert.assertEquals( configuration.locales, locale.parent );
			
			Assert.assertNotNull( configuration.locales.resources );
			Assert.assertEquals( configuration.locales, configuration.locales.resources.parent );
			
			Assert.assertNotNull( locale.resources );
			Assert.assertEquals( locale, locale.resources.parent );
			
			//test global resources
			var resources:IResourceManager = configuration.locales.resources;
			var rsls:IResourceCollection = resources.rsls;
			
			var resource:IRuntimeResource = rsls[ 0 ];

			Assert.assertNotNull( resource );
			Assert.assertEquals( rsls, resource.parent );
			
			Assert.assertEquals( configuration.locales, resource.parent.parent.parent );
			Assert.assertEquals( configuration, ILocaleManager( resource.parent.parent.parent ).parent );
			Assert.assertEquals( "mock-assets/common/swf/application-assets.swf", resource.getTranslatedPath() );
			
			//test a locale specific load process
			resources = locale.resources;
			resource = resources.messages[ 0 ];
			
			//trace("ConfigurationLoadTest::assertLoadedConfiguration", resource, resource.url, resource.getTranslatedPath() );
			Assert.assertEquals( "mock-assets/locales/en-GB/properties/messages.properties", resource.getTranslatedPath() );
		}
	
		[Test(async)]
		public function loadConfiguration():void
		{
			//
		}
	}
}