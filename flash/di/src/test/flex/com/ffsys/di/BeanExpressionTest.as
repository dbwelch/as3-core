package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	import flash.display.Sprite;
	
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
			assertExpressions( document );
		}
	}
}