package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
	/**
	*	Unit tests for css expressions.
	*/ 
	public class BeanExpressionTest
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
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			
			Assert.assertNotNull( document );
			Assert.assertEquals( 4, document.length );
			
			var style:Object = document.getBean( "expressions" );
			Assert.assertNotNull( style );

			Assert.assertTrue( style.classExpression is Class );
			Assert.assertTrue( style.urlExpression is URLRequest );
			Assert.assertEquals( Sprite, style.classExpression );
			Assert.assertEquals( 16711680, style.red );
			
			var singleton:Object = document.getBean( "stylable" );
			Assert.assertEquals( singleton, document.constants.stylable );
			
			Assert.assertEquals( singleton, document.getBean( "stylable" ) );			
			
			var arrays:Object = document.getBean( "arrays" );
			Assert.assertNotNull( arrays );			
			
			Assert.assertTrue( arrays.values is Array );
			
			Assert.assertEquals( 16711680, arrays.values[ 0 ] );
			Assert.assertEquals( "hello world", arrays.values[ 1 ] );
			Assert.assertEquals( singleton, arrays.values[ 2 ] );
		}
	}
}