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
	public class BeanStaticMethodTest extends AbstractBeanUnit
	{	
		private var _quad:Quad;
		
		public var sample:String = 
			(<![CDATA[
			
			quad-ease-in {
				static-class: class( org.flashx.effects.easing.Quad );
				method: method( easeIn );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanStaticMethodTest</code> instance.
		*/ 
		public function BeanStaticMethodTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying beans that reference a static function.
		*/
		[Test]
		public function beanStaticMethodTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			Assert.assertNotNull( document );
			
			var easeIn:Object = document.getBean( "quad-ease-in" );
			Assert.assertNotNull( easeIn );
			Assert.assertTrue( easeIn is Function );
		}
	}
}