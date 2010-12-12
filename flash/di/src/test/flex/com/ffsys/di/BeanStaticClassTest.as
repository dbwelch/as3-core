package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import com.ffsys.effects.easing.Quad;
	
	/**
	*	Unit tests for bean referencing static class beans.
	*/ 
	public class BeanStaticClassTest extends AbstractBeanUnit
	{	
		private var _quad:Quad;
		
		public var sample:String = 
			(<![CDATA[
			
			constants {
				quad-static: class( com.ffsys.effects.easing.Quad );
			}
			
			quad {
				static-class: class( com.ffsys.effects.easing.Quad );
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
		* 	Tests for verifying reference expressions declared in text files.
		*/
		[Test]
		public function beanReferenceTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			Assert.assertNotNull( document );
			Assert.assertEquals( 3, document.length );
			var quad:Object = document.getBean( "quad" );
			Assert.assertTrue( quad is Class );
			var quadConstant:Object = document.getBean( "quad-constant" );
			Assert.assertTrue( quadConstant is Class );
		}
	}
}