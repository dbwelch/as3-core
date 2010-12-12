package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import com.ffsys.effects.easing.Quad;
	
	/**
	*	Unit tests for bean referencing static methods.
	*/ 
	public class BeanInstanceMethodTest extends AbstractBeanUnit
	{	
		private var _quad:Quad;
		
		public var sample:String = 
			(<![CDATA[

			instance-method {
				instance-class: class( com.ffsys.di.BeanInstanceMethodTest );
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
			Assert.assertEquals( 1, document.length );
			
			var instanceMethod:Object = document.getBean( "instance-method" );
			Assert.assertNotNull( instanceMethod );
			Assert.assertTrue( instanceMethod is Function );
		}
	}
}