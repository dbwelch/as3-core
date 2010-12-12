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
	
	import com.ffsys.effects.easing.*;
	import com.ffsys.effects.tween.*;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Unit tests for parsing css files.
	*/ 
	public class CssParseTest
	{
		
		private var _rectangle:RectangleGraphic;
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;
		private var _quad:Quad;
		private var _styleAware:CssStyleAware;
		
		private var _tween:Tween;
		private var _tweenGroup:TweenGroup;
		private var _tweenSequence:TweenSequence;
		
		public var sample:String = 
			(<![CDATA[
			
				constants {
					color: #ff6600;
					rectangle: class( com.ffsys.ui.graphics.RectangleGraphic );
					fill: ref( default-fill );
					stroke: ref( default-stroke );
				}
			
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

				references {
					rectangle: ref( rectangle );
					fill: ref( default-fill );
					stroke: ref( default-stroke );
					color: ref( default-stroke.color );
				}
				
				singleton-fill {
					instance-class: class( com.ffsys.ui.graphics.SolidFill );
					singleton: true;
					color: #ff0000;
					alpha: 0.5;
				}
				
				style-aware {
					instance-class: class( com.ffsys.ui.css.CssStyleAware );
					method: method( doSomethingSpecial );
				}
				
				quad {
					static-class: class( com.ffsys.effects.easing.Quad );
				}
				
				quad-ease-in {
					static-class: class( com.ffsys.effects.easing.Quad );
					method: method( easeIn );
				}
				
				tween {
					instance-class: class( com.ffsys.effects.tween.Tween );
					parameters: ref( alpha-tween );
				}
				
				alpha-tween {
					instance-class: class( com.ffsys.effects.tween.TweenParameters );
					properties: array( alpha );
					easing: array( ref( quad-ease-in ) );
					start-values: array( 0 );
					end-values: array( 1 );	
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
			
			/*
			trace("START ASSERTIONS");
			
			var references:Object = stylesheet.getStyle( "references" );
			trace("CssParseTest::cssParseTest()", "RECT: ", references.rectangle );
			
			Assert.assertTrue( references.rectangle is RectangleGraphic );
			return;
			*/
			
			var rectangle:Object = stylesheet.getStyle( "rectangle" );			
			var defaultStroke:Object = stylesheet.getStyle( "default-stroke" );
			var defaultFill:Object = stylesheet.getStyle( "default-fill" );
			var references:Object = stylesheet.getStyle( "references" );
			
			var fill1:Object = stylesheet.getStyle( "default-fill" );
			var fill2:Object = stylesheet.getStyle( "default-fill" );
			//check that when retrieving the same style the return values correspond to different instances
			Assert.assertTrue( fill1 != fill2 );
			
			Assert.assertNotNull( stylesheet.constants );
			
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
			
			var rect1:IComponentGraphic = IComponentGraphic( stylesheet.getStyle( "rectangle" ) );
			var rect2:IComponentGraphic = IComponentGraphic( stylesheet.getStyle( "rectangle" ) );
			Assert.assertTrue( rect1 != rect2 );
			
			Assert.assertTrue( rect1.fill != rect2.fill );
			
			var color:Number = 0xff1234;
			var sFill1:SolidFill = SolidFill( stylesheet.getStyle( "singleton-fill" ) );
			var sFill2:SolidFill = SolidFill( stylesheet.getStyle( "singleton-fill" ) );
			
			//ensure singletons are equal
			Assert.assertEquals( sFill1, sFill2 );
			
			//assert setting properties are equal on singletons
			sFill1.color = color;
			Assert.assertEquals( sFill1.color, sFill2.color );
			
			var easing:Class = Class( stylesheet.getStyle( "quad" ) );
			
			//assertion on static class
			Assert.assertNotNull( easing );
			Assert.assertEquals( Quad, easing );
			
			//easeIn
			var easeIn:Object = stylesheet.getStyle( "quad-ease-in" );
			Assert.assertNotNull( easeIn );
			Assert.assertTrue( easeIn is Function );
			
			var instanceMethod:Object = stylesheet.getStyle( "style-aware" );
			Assert.assertNotNull( instanceMethod );
			Assert.assertTrue( instanceMethod is Function );
			
			var tween:ITween = stylesheet.getStyle( "tween" ) as ITween;
			Assert.assertNotNull( tween );
		}
	}
}