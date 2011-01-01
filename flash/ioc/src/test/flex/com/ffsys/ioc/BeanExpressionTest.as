package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import flash.display.*;
	import flash.geom.*;
	import flash.net.*;
	
	import com.ffsys.color.*;
	
	/**
	*	Unit tests for bean expressions.
	*/ 
	public class BeanExpressionTest extends AbstractBeanUnit
	{	
		public var sample:String = 
			(<![CDATA[
			
			constants {
				constant-class: class( flash.display.Sprite );
				red: #ff0000;
				string: hello world;
				stylable: ref( stylable );
			}

			expressions {
				class-expression: class( flash.display.Sprite );
				url-expression: url( http://google.com );
				red: constant( red );
				constant-class: constant( constant-class );
				point: point( 16, 32 );
				rect: rect( 16, 32, 64, 128 );
				matrix: matrix( 16, 32, 64, 128, 256, 512 );
				color-transform: color( 2, 4, 6, 8, 10, 12, 14, 16 );
			}
			
			arrays {
				values: array( constant( red ), constant( string ), constant( stylable ) );
			}
			
			stylable {
				singleton: true;
				instance-class: class( flash.display.Sprite );
			}
			
			colors {
				rgb: rgb( 255, 128, 0 );
				hsl: hsl( 36, 1, 1 );
				tint: tint( #ff9900, 1 );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>BeanExpressionTest</code> instance.
		*/
		public function BeanExpressionTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying expressions declared in text files.
		*/
		[Test]
		public function beanExpressionTest():void
		{
			var document:IBeanDocument = new BeanDocument();
			document.parse( sample );
			
			Assert.assertNotNull( document );
			Assert.assertEquals( 5, document.length );
			assertExpressions( document );
			
			var expressions:Object = document.getBean( "expressions" );
			Assert.assertNotNull( expressions );
			
			var point:Object = expressions.point;
			Assert.assertTrue( point is Point );
			var p:Point = Point( point );
			Assert.assertEquals( 16, p.x );
			Assert.assertEquals( 32, p.y );
			
			var rect:Object = expressions.rect;
			Assert.assertTrue( rect is Rectangle );
			var r:Rectangle = Rectangle( rect );
			Assert.assertEquals( 16, r.left );
			Assert.assertEquals( 32, r.top );
			Assert.assertEquals( 64, r.width );
			Assert.assertEquals( 128, r.height );
			
			var matrix:Object = expressions.matrix;
			Assert.assertTrue( matrix is Matrix );
			var m:Matrix = Matrix( matrix );
			Assert.assertEquals( 16, m.a );
			Assert.assertEquals( 32, m.b );
			Assert.assertEquals( 64, m.c );
			Assert.assertEquals( 128, m.d );
			Assert.assertEquals( 256, m.tx );
			Assert.assertEquals( 512, m.ty );

			var color:Object = expressions.colorTransform;
			Assert.assertTrue( color is ColorTransform );
			var c:ColorTransform = ColorTransform( color );
			Assert.assertEquals( 2, c.redMultiplier );
			Assert.assertEquals( 4, c.greenMultiplier );
			Assert.assertEquals( 6, c.blueMultiplier );
			Assert.assertEquals( 8, c.alphaMultiplier );
			Assert.assertEquals( 10, c.redOffset );
			Assert.assertEquals( 12, c.greenOffset );
			Assert.assertEquals( 14, c.blueOffset );
			Assert.assertEquals( 16, c.alphaOffset );
			
			//TODO: add more assertions on rgb() / hsl() and tint() expressions
			var colors:Object = document.getBean( "colors" );
			Assert.assertTrue( colors.rgb is RgbColor );
			Assert.assertTrue( colors.hsl is HslColor );
			Assert.assertTrue( colors.tint is HslColor );
		}
	}
}