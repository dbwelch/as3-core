package com.ffsys.swat.configuration
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.swat.AbstractUnit;
	
	import com.ffsys.io.loaders.core.*;	
	import com.ffsys.io.loaders.events.*;	
	
	import com.ffsys.swat.events.*;
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.swat.configuration.rsls.*;
	import com.ffsys.swat.core.*;	
	
	import com.ffsys.swat.mock.*;
	
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
		public var configuration:IConfiguration;
		
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
			configuration = IConfiguration( event.configuration );

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
			
			//TODO: re-implement these tests with the updated mock configuration
			
			/*
			//test global resources
			var resources:IResourceDefinitionManager = configuration.locales.resources;
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
			*/
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function assertBootstrapData(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			var beanConfiguration:BeanConfiguration = new BeanConfiguration();
			beanConfiguration.doWithBeans( configuration.locales.document, configuration, bootstrap.resources );
			
			var mainBeanName:String = DefaultBeanIdentifiers.APPLICATION_BEAN;
			
			//get the main mock application controller
			var application:MockApplicationController = configuration.getBean( mainBeanName ) as MockApplicationController;
			Assert.assertNotNull( application );
			
			//verify singleton behaviour
			Assert.assertEquals( application, configuration.getBean( mainBeanName ) );
			
			//bean xref from the stylesheet document
			Assert.assertNotNull( application.rectangle );
			
			//check that the type injection by interface implementation works
			Assert.assertNotNull( application.locales );
			Assert.assertNotNull( application.messages );
			Assert.assertNotNull( application.paths );
			Assert.assertNotNull( application.locale );
			Assert.assertNotNull( application.resources );
		}
	
		[Test(async)]
		public function loadConfiguration():void
		{
			//
		}
	}
}