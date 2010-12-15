package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Unit tests for bean constant expressions.
	*/ 
	public class BeanConstantsTest extends AbstractBeanUnit
	{	
		public var sample:String = 
			(<![CDATA[
			
			constants {
				rectangle: class( com.ffsys.ui.graphics.RectangleGraphic );
				fill: ref( default-fill );
				stroke: ref( default-stroke );
			}

			rectangle {
				instance-class: constant( rectangle );
				fill: constant( fill );
				stroke: constant( stroke );
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
		*	Creates a <code>BeanConstantsTest</code> instance.
		*/ 
		public function BeanConstantsTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying reference expressions declared in text files.
		*/
		[Test]
		public function beanConstantsTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );

			Assert.assertNotNull( document );
			Assert.assertEquals( 4, document.length );
		
			var constants:Object = document.constants;
			Assert.assertNotNull( constants );
			Assert.assertTrue( constants.rectangle is Class );	
			Assert.assertTrue( constants.fill is SolidFill );
			Assert.assertTrue( constants.stroke is Stroke );
		}
	}
}