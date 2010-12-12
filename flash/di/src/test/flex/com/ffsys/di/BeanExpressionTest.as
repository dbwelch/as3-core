package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import flash.display.*;
	import flash.geom.*;
	import flash.net.*;
	
	/**
	*	Unit tests for css expressions.
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
			}
			
			arrays {
				values: array( constant( red ), constant( string ), constant( stylable ) );
			}
			
			stylable {
				singleton: true;
				instance-class: class( flash.display.Sprite );
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
			Assert.assertEquals( 4, document.length );
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
		}
	}
}