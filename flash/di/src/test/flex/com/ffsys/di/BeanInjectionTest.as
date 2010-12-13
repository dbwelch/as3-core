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
		
		public var sample:String = 
			(<![CDATA[
			
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
			Assert.assertEquals( 4, document.length );
			
			var application:Object = document.getBean( "application" );
			Assert.assertNotNull( application );
			Assert.assertTrue( application is MockApplicationBean );
			
			var app:MockApplicationBean = MockApplicationBean( application );
			
			Assert.assertNotNull( app.configuration );
			Assert.assertTrue( app.configuration is MockConfigurationBean );
			
			Assert.assertNotNull( app.messages );
			Assert.assertTrue( app.messages is MockMessagesBean );
		}
	}
}