package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.effects.easing.*;
	import com.ffsys.effects.tween.*;	
	
	/**
	*	Unit tests for css tween declarations.
	*/ 
	public class CssTweenTest
	{	
		private var _tween:Tween;
		private var _tweenGroup:TweenGroup;
		private var _tweenSequence:TweenSequence;		
		
		public var sample:String = 
			(<![CDATA[
			
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
		*	Creates a <code>CssTweenTest</code> instance.
		*/ 
		public function CssTweenTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying filters declared in css files.
		*/
		[Test]
		public function cssTweenTest():void
		{
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var easing:Class = Class( stylesheet.getStyle( "quad" ) );
			
			//assertion on static class
			Assert.assertNotNull( easing );
			Assert.assertEquals( Quad, easing );
			
			//easeIn
			var easeIn:Object = stylesheet.getStyle( "quad-ease-in" );
			Assert.assertNotNull( easeIn );
			Assert.assertTrue( easeIn is Function );
			
			var tween:ITween = stylesheet.getStyle( "tween" ) as ITween;
			
			Assert.assertNotNull( tween );
			Assert.assertNotNull( tween.parameters );
			
			trace("CssTweenTest::cssTweenTest()", tween.parameters, tween.parameters.easing );
			
			Assert.assertNotNull( tween.parameters.properties );
			
			/*
			var tween:ITween = ITween( getStyle( "alpha-tween" ) );
			tween.target = graphic;
			tween.initialize();
			tween.start();
			*/
		}
	}
}