package org.flashx.swat.configuration
{
	import flash.display.*;
	import flash.media.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.ioc.*;
	
	import org.flashx.swat.AbstractUnit;
	
	import org.flashx.io.loaders.core.*;	
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	import org.flashx.swat.events.*;
	import org.flashx.swat.configuration.*;
	import org.flashx.swat.configuration.locale.*;
	import org.flashx.swat.configuration.rsls.*;
	import org.flashx.swat.core.*;	
	
	import org.flashx.swat.mock.*;
	import org.flashx.swat.mock.model.*;
	
	import org.flashx.utils.properties.IProperties;
	
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
	public class BootstrapLoadTest extends AbstractUnit
	{
		public var configuration:IConfiguration;
		
		/**
		* 	Creats a <code>BootstrapLoadTest</code> instance.
		*/
		public function BootstrapLoadTest()
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
			
			//trace("BootstrapLoadTest::assertLoadedConfiguration()", configuration.locales.resources.components );

			Assert.assertNotNull( configuration );
			Assert.assertNotNull( configuration.locales );
			Assert.assertNotNull( configuration.locales.resources );
			
			Assert.assertEquals( 4, configuration.locales.length );
			
			var locales:Array = configuration.locales.getLocales();
			
			Assert.assertEquals( 4, locales.length );
			
			var locale:IConfigurationLocale = IConfigurationLocale( locales[ 0 ] );
			Assert.assertNotNull( locale );
			
			Assert.assertNotNull( configuration.locales.resources );
			Assert.assertNotNull( locale.resources );
			
			//TODO: re-implement these tests with the updated mock configuration
			
			//test global resources
			var resources:IResourceDefinitionManager = configuration.locales.resources;
			var rsls:IResourceCollection = resources.rsls;
			
			var resource:IRuntimeResource = rsls[ 0 ];

			Assert.assertNotNull( resource );
			
			Assert.assertEquals( "mock-assets/common/swf/mock-assets.swf", resource.getTranslatedPath() );
			
			//test a locale specific resource definition
			resources = locale.resources;
			resource = resources.messages[ 0 ];
			
			//trace("BootstrapLoadTest::assertLoadedConfiguration", resource, resource.url, resource.getTranslatedPath() );
			Assert.assertEquals( "mock-assets/locales/en-GB/properties/mock-messages.properties",
				resource.getTranslatedPath( configuration.paths, locale ) );
			
			//check component definitions
			Assert.assertNotNull( configuration.locales.resources.components );
			Assert.assertEquals( 2, configuration.locales.resources.components.length );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function assertBootstrapData(
			event:RslEvent,
			passThroughData:Object ):void
		{
			var document:IBeanDocument = configuration.resources.document;
			document.xrefs.push( this.framework, configuration.stylesheet );
			
			var beanConfiguration:BeanConfiguration = new BeanConfiguration();
			beanConfiguration.doWithBeans(
				document,
				configuration,
				configuration.resources );
			
			var mainBeanName:String = DefaultBeanIdentifiers.APPLICATION;
			
			//check the number of resources that were not found
			Assert.assertEquals( 1, bootstrap.resources.missing.length );
			
			//get the main mock application controller
			var application:MockApplicationController =
				configuration.getBean( mainBeanName ) as MockApplicationController;
			Assert.assertNotNull( application );
			
			//verify singleton behaviour
			Assert.assertEquals( application, configuration.getBean( mainBeanName ) );
			
			//bean xref from the stylesheet document
			Assert.assertNotNull( application.rectangle );
			
			//check that the type injection by interface implementation works
			
			//TODO: fix type injection with document xrefs
			Assert.assertNotNull( application.locales );
			
			Assert.assertNotNull( application.messages );
			Assert.assertNotNull( application.errors );
			Assert.assertNotNull( application.settings );
			Assert.assertNotNull( application.paths );
			Assert.assertNotNull( application.locale );
			Assert.assertNotNull( application.resources );
			
			//verify global resources
			Assert.assertNotNull( application.resources.messages );
			Assert.assertNotNull( application.resources.errors );
			Assert.assertNotNull( application.resources.settings );
			Assert.assertNotNull( application.resources.xml );
			Assert.assertNotNull( application.resources.text );
			Assert.assertNotNull( application.resources.rsls );
			Assert.assertNotNull( application.resources.images );
			Assert.assertNotNull( application.resources.sounds );

			//check global resource list lengths
			Assert.assertEquals( 1, application.resources.xml.length );
			Assert.assertEquals( 1, application.resources.text.length );
			Assert.assertEquals( 1, application.resources.rsls.length );
			
			Assert.assertEquals( 2, application.resources.images.length );
			
			Assert.assertEquals( 1, application.resources.sounds.length );
			
			//check the data associated with a type based resource list is correct
			assertResourceListType( XML, application.resources.xml );
			assertResourceListType( String, application.resources.text );
			assertResourceListType( Loader, application.resources.rsls );
			assertResourceListType( BitmapData, application.resources.images );
			assertResourceListType( Sound, application.resources.sounds );
			
			/*
			trace("BootstrapLoadTest::assertBootstrapData() checking components: ", application.resources.components, application.resources.components.length, application.resources.getComponent( "header" ) );
			*/
			
			//xml bean component definition
			var model:Object = application.resources.getComponent( "model" );
			Assert.assertTrue( model is MockApplicationModel );
			
			//standard bean definition
			var header:Object = application.resources.getComponent( "header" );
			Assert.assertNotNull( header );
			
			var expected:String = "This is an english locale message override.";
			//check dot style property access
			Assert.assertEquals( expected, Object( application.messages ).common.message );
			//check api style access
			Assert.assertEquals( expected, configuration.getMessage( "common.message" ) );
			
			expected = "An error of type {0} en_GB occured.";
			//check dot style property access
			Assert.assertEquals( expected, Object( application.errors ).general );
			//check api style access
			Assert.assertEquals( expected, configuration.getError( "general" ) );
			
			//assert on loaded assets via api access
			var x:XML = configuration.getXmlDocument( "mockXml" );
			Assert.assertNotNull( x );
			var s:Sound = configuration.getSound( "mockSound" );			
			Assert.assertNotNull( s );
			var b:Bitmap = configuration.getImage( "mockImage001" );
			Assert.assertNotNull( b );
			b = configuration.getImage( "mockImage002" );
			Assert.assertNotNull( b );
			var l:Loader = configuration.getMovie( "mockAssets" );
			Assert.assertNotNull( l );
			
			//check injected bean file resource dependencies have been resolved
			var style:Object = configuration.getStyle( "css-dependency-test" );
			Assert.assertTrue( style.propertyBitmap is BitmapData );
			Assert.assertTrue( style.propertySound is Sound );
			Assert.assertTrue( style.propertyMovie is Loader );
			Assert.assertTrue( style.propertyXml is XML );
			Assert.assertTrue( style.propertyText is String );
			Assert.assertTrue( style.propertyFont is Array );
			Assert.assertTrue( style.propertyMessages is IProperties );
			
			//application setting primitives
			
			//string setting
			var expectedString:String = "3d";
			Assert.assertEquals( expectedString,
				Object( application.settings ).application.mode );
			Assert.assertEquals( expectedString, configuration.getSetting( "application.mode" ) );
			
			//boolean false setting
			Assert.assertFalse( Object( application.settings ).application.launch.enabled );
			
			/*
			Assert.assertFalse( configuration.getSetting( "application.launch.enabled" ) );
			
			//boolean true setting
			Assert.assertTrue( Object( application.settings ).application.login.enabled );
			Assert.assertTrue( configuration.getSetting( "application.login.enabled" ) );
			*/
		}
		
		/**
		* 	Asserts that all the resources stored in a resource list are of the
		* 	specified type.
		* 
		* 	@param type The expected type.
		* 	@param list The resource list.
		*/
		protected function assertResourceListType(
			type:Class, list:IResourceList ):void
		{
			var element:IResourceElement = null;
			for( var i:int = 0;i < list.length;i++ )
			{
				element = list.getResourceAt( i );
				Assert.assertTrue( element is IResource );
				Assert.assertTrue( IResource( element ).data is type );
			}
		}
	
		[Test(async)]
		public function loadConfiguration():void
		{
			//
		}
	}
}