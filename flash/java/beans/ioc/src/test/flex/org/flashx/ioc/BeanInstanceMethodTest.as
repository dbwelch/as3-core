package org.flashx.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import org.flashx.effects.easing.Quad;
	
	/**
	*	Unit tests for bean referencing static methods.
	*/ 
	public class BeanInstanceMethodTest extends AbstractBeanUnit
	{	
		private var _quad:Quad;
		
		public var sample:String = 
			(<![CDATA[

			instance-method {
				instance-class: class( org.flashx.ioc.BeanInstanceMethodTest );
				method: method( doSomethingSpecial );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanInstanceMethodTest</code> instance.
		*/
		public function BeanInstanceMethodTest()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		public function doSomethingSpecial():void
		{
			//
		}
		
		/**
		* 	Tests for verifying beans that reference an instance function.
		*/
		[Test]
		public function beanInstanceMethodTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			Assert.assertNotNull( document );
			
			var instanceMethod:Object = document.getBean( "instance-method" );
			Assert.assertNotNull( instanceMethod );
			Assert.assertTrue( instanceMethod is Function );
		}
	}
}