package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Unit tests for bean references.
	*/ 
	public class BeanReferenceTest extends AbstractBeanUnit
	{	
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

			references {
				rectangle: ref( rectangle );
				fill: ref( default-fill );
				stroke: ref( default-stroke );
				color: ref( default-stroke.color );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanReferenceTest</code> instance.
		*/ 
		public function BeanReferenceTest()
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
			Assert.assertEquals( 5, document.length );
			Assert.assertTrue( document.constants.rectangle is Class );
			Assert.assertTrue( document.constants.fill is SolidFill );
			Assert.assertTrue( document.constants.stroke is Stroke );
			
			var rectangle:RectangleGraphic = RectangleGraphic(
				document.getBean( "rectangle" ) );
			
		}
	}
}