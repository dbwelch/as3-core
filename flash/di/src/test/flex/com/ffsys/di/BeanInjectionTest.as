package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import com.ffsys.di.mock.*;
	
	import com.ffsys.ui.graphics.*;
	
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
				instance-class: class( com.ffsys.di.BeanInjector );
				singleton: true;
			}
			
			application {
				instance-class: class( com.ffsys.di.mock.MockApplicationBean );
				singleton: true;
			}
			
			messages {
				instance-class: class( com.ffsys.di.mock.MockMessagesBean );
				singleton: true;
			}
			
			configuration {
				instance-class: class( com.ffsys.di.mock.MockConfigurationBean );
				singleton: true;
			}
			
			applicationController {
				instance-class: class( com.ffsys.di.mock.MockApplicationControllerBean );
				singleton: true;
				controller: ref( home-controller );
			}
			
			locales {
				instance-class: class( com.ffsys.di.mock.MockLocaleManager );
				singleton: true;
			}
			
			home-controller {
				instance-class: class( com.ffsys.di.mock.MockHomeController );
			}
			
			loader {
				factory: ref( loader-factory );
			}
			
			loader-factory {
				static-class: class( com.ffsys.di.mock.MockFactoryBean );
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
			Assert.assertEquals( 9, document.length );
			
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
			
			trace("BeanInjectionTest::beanInjectionTest()", app.applicationController );
			
			var loader:Object = document.getBean( "loader" );
		}
	}
}