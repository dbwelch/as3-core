package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Unit tests for css graphics.
	*/ 
	public class CssGraphicTest
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
		*	Creates a <code>CssGraphicTest</code> instance.
		*/ 
		public function CssGraphicTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying graphics declared in css files.
		*/
		[Test]
		public function cssGraphicTest():void
		{
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var rectangle:RectangleGraphic = RectangleGraphic( stylesheet.getStyle( "rectangle" ) );
			var fill:SolidFill = SolidFill( stylesheet.getStyle( "default-fill" ) );
			var stroke:Stroke = Stroke( stylesheet.getStyle( "default-stroke" ) );
			
			Assert.assertNotNull( rectangle );
			Assert.assertNotNull( fill );
			Assert.assertNotNull( stroke );
			
			Assert.assertNotNull( rectangle.fill );
			Assert.assertNotNull( rectangle.stroke );
			
			Assert.assertEquals( 1, rectangle.stroke.thickness );
			Assert.assertEquals( 16711680, rectangle.stroke.color );
			Assert.assertEquals( 0.5, rectangle.stroke.alpha );
		}
	}
}