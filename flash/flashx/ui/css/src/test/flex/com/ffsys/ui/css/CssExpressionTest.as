package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.net.*;
	
	/**
	*	Unit tests for css expressions.
	*/ 
	public class CssExpressionTest
	{	
		public var sample:String = 
			(<![CDATA[
			
			constants {
				constant-class: class( com.ffsys.ui.css.CssStyleAware );
				red: #ff0000;
				string: hello world;
				stylable: ref( stylable );
			}

			expressions {
				class-expression: class( com.ffsys.ui.css.CssStyleAware );
				url-expression: url( http://google.com );
				red: constant( red );
				constant-class: constant( constant-class );
			}
			
			arrays {
				values: array( constant( red ), constant( string ), constant( stylable ) );
			}
			
			stylable {
				singleton: true;
				instance-class: class( com.ffsys.ui.css.CssStyleAware );
			}

			]]>).toString();
		
		/**
		*	Creates a <code>CssExpressionTest</code> instance.
		*/ 
		public function CssExpressionTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying filters declared in css files.
		*/
		[Test]
		public function cssExpressionTest():void
		{
			/*
			var style:Object = new CssStyle( { color: 0xff00ff, size: 20 } );
			for( var z:String in style )
			{
				trace("************ CssExpressionTest::got style value: ()", z, style[ z ] );
			}
			return;			
			*/			
			
			var stylable:CssStyleAware = null;
			
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var style:Object = stylesheet.getStyle( "expressions" );
			Assert.assertNotNull( style );


			Assert.assertTrue( style.classExpression is Class );
			Assert.assertTrue( style.urlExpression is URLRequest );
			Assert.assertEquals( CssStyleAware, style.classExpression );
			Assert.assertEquals( 16711680, style.red );
			
			var singleton:Object = stylesheet.getStyle( "stylable" );
			Assert.assertEquals( singleton, stylesheet.constants.stylable );
			Assert.assertEquals( singleton, stylesheet.getStyle( "stylable" ) );			
			
			var arrays:Object = stylesheet.getStyle( "arrays" );
			Assert.assertNotNull( arrays );			
			
			Assert.assertTrue( arrays.values is Array );
			Assert.assertEquals( 16711680, arrays.values[ 0 ] );
			Assert.assertEquals( "hello world", arrays.values[ 1 ] );
			Assert.assertEquals( singleton, arrays.values[ 2 ] );
		}
	}
}