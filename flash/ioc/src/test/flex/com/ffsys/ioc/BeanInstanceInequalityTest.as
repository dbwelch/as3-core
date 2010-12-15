package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Unit tests for bean ensuring bean references to not point to the same instance.
	*/ 
	public class BeanInstanceInequalityTest extends AbstractBeanUnit
	{	
		private var _rect:RectangleGraphic;
		private var _fill:SolidFill;
		private var _stroke:Stroke;
		
		public var sample:String = 
			(<![CDATA[
			
			constants {
				rectangle: class( com.ffsys.ui.graphics.RectangleGraphic );
				fill: ref( default-fill );
				stroke: ref( default-stroke );
			}
			
			rectangle {
				instance-class: class( com.ffsys.ui.graphics.RectangleGraphic );
				fill: ref( default-fill );
				stroke: ref( default-stroke );
				preferred-width: 20;
				preferred-height: 20;
			}

			default-fill {
				instance-class: class( com.ffsys.ui.graphics.SolidFill );
				color: #00ff00;
				alpha: 0.5;
			}

			default-stroke {
				instance-class: class( com.ffsys.ui.graphics.Stroke );
				thickness: 1;
				color: #ff0000;
				alpha: 0.5;
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanInstanceInequalityTest</code> instance.
		*/ 
		public function BeanInstanceInequalityTest()
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
			Assert.assertEquals( 4, document.length );
			
			var rect1:IComponentGraphic = IComponentGraphic( document.getBean( "rectangle" ) );
			var rect2:IComponentGraphic = IComponentGraphic( document.getBean( "rectangle" ) );
			Assert.assertTrue( rect1 != rect2 );
			Assert.assertTrue( rect1.fill != rect2.fill );
			Assert.assertTrue( rect1.stroke != rect2.stroke );
		}
	}
}