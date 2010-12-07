package com.ffsys.ui.css
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Unit tests for parsing css files.
	*/ 
	public class CssParseTest
	{
		
		private var _rectangle:RectangleGraphic;
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;		
		
		public var sample:String = 
			(<![CDATA[
				test-style {
					property-string: a test string;
					property-number: 10;
					property-float: 1.67;
					property-true: true;
					property-false: false;
					property-null: null;
					property-undefined: undefined;
					property-nan: NaN;
					property-array: apples|10|3.14|true;
					property-class: class ( flash.display.Sprite );
				}

				rectangle {
					instance-class: class( com.ffsys.ui.graphics.RectangleGraphic );
					fill-style: default-fill;
					stroke-style: default-stroke;
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
		*	Creates a <code>CssParseTest</code> instance.
		*/ 
		public function CssParseTest()
		{
			super();
		}
		
		[Test]
		public function cssParseTest():void
		{
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var rectangle:Object = stylesheet.getStyle( "rectangle" );
			var defaultStroke:Object = stylesheet.getStyle( "default-stroke" );
			var defaultFill:Object = stylesheet.getStyle( "default-fill" );
			var references:Object = stylesheet.getStyle( "references" );
			trace("CssParseTest::cssParseTest()", "GOT RECT: ", references.rectangle );			
			
			Assert.assertNotNull( rectangle );
			Assert.assertNotNull( defaultStroke );
			Assert.assertNotNull( defaultFill );
			
			Assert.assertTrue( defaultStroke is Stroke );
			Assert.assertTrue( defaultFill is SolidFill );
			
			Assert.assertNotNull( references );
			Assert.assertTrue( references.rectangle is RectangleGraphic );
			Assert.assertTrue( references.fill is SolidFill );
			Assert.assertTrue( references.stroke is Stroke );
			
			//check the colour property references
			Assert.assertEquals( defaultStroke.color, references.color );
		}
	}
}