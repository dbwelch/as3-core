package org.flashx.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import org.flashx.ioc.mock.*;
	
	/**
	*	Unit tests for automatic bean injection.
	*/ 
	public class BeanInjectionTest extends AbstractBeanUnit
	{	
		private var _mock:MockApplicationBean;
		private var _home:MockHomeController;
		private var _injector:BeanInjector;
		private var _factory:MockFactoryBean;
		
		public var sample:String = 
			(<![CDATA[
			
			injector {
				instance-class: class( org.flashx.ioc.BeanInjector );
				singleton: true;
			}
			
			application {
				instance-class: class( org.flashx.ioc.mock.MockApplicationBean );
				singleton: true;
			}
			
			messages {
				instance-class: class( org.flashx.ioc.mock.MockMessagesBean );
				singleton: true;
			}
			
			configuration {
				instance-class: class( org.flashx.ioc.mock.MockConfigurationBean );
				singleton: true;
			}
			
			applicationController {
				instance-class: class( org.flashx.ioc.mock.MockApplicationControllerBean );
				singleton: true;
				controller: ref( home-controller );
			}
			
			locales {
				instance-class: class( org.flashx.ioc.mock.MockLocaleManager );
				singleton: true;
			}
			
			home-controller {
				instance-class: class( org.flashx.ioc.mock.MockHomeController );
			}
			
			loader {
				factory: ref( loader-factory );
			}
			
			loader-factory {
				static-class: class( org.flashx.ioc.mock.MockFactoryBean );
				method: method( getLoaderInstance );
			}
			
			]]>).toString();
		
		/**
		*	Creates a <code>BeanInjectionTest</code> instance.
		*/ 
		public function BeanInjectionTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying automatic bean injection.
		*/
		[Test]
		public function beanInjectionTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			Assert.assertNotNull( document );
			
			var application:Object = document.getBean( "application" );
			Assert.assertNotNull( application );
			Assert.assertTrue( application is MockApplicationBean );
			
			var app:MockApplicationBean = MockApplicationBean( application );
			
			Assert.assertNotNull( app.configuration );
			Assert.assertTrue( app.configuration is MockConfigurationBean );
			
			Assert.assertNotNull( app.messages );
			Assert.assertTrue( app.messages is MockMessagesBean );
			
			Assert.assertNotNull( app.configuration.locales );
			Assert.assertTrue( app.configuration.locales is MockLocaleManager );

			var loader:Object = document.getBean( "loader" );
			Assert.assertTrue( loader is MockLoaderBean );
			Assert.assertEquals( "test", loader.type );
		}
	}
}