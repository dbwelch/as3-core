package org.flashx.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import org.flashx.effects.easing.Quad;
	
	/**
	*	Unit tests for beans that return as class references.
	*/ 
	public class BeanStaticClassTest extends AbstractBeanUnit
	{	
		private var _quad:Quad;
		
		public var sample:String = 
			(<![CDATA[
			
			constants {
				quad-static: class( org.flashx.effects.easing.Quad );
			}
			
			quad {
				static-class: class( org.flashx.effects.easing.Quad );
			}
			
			quad-constant {
				static-class: constant( quad-static );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanStaticClassTest</code> instance.
		*/ 
		public function BeanStaticClassTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying beans that return as class references.
		*/
		[Test]
		public function beanStaticClasTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			Assert.assertNotNull( document );
			var quad:Object = document.getBean( "quad" );
			Assert.assertTrue( quad is Class );
			var quadConstant:Object = document.getBean( "quad-constant" );
			Assert.assertTrue( quadConstant is Class );
		}
	}
}