package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Unit tests for declaring graphics as beans.
	*/ 
	public class BeanGraphicTest extends AbstractBeanUnit
	{		
		public var sample:String = 
			(<![CDATA[

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
		*	Creates a <code>BeanGraphicTest</code> instance.
		*/ 
		public function BeanGraphicTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying graphics declared in bean files.
		*/
		[Test]
		public function beanGraphicTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			
			Assert.assertNotNull( document );
			Assert.assertEquals( 3, document.length );			
			
			assertGraphicBeans( document );
		}
	}
}