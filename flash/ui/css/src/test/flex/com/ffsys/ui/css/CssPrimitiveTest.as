package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for css primitive values.
	*/ 
	public class CssPrimitiveTest
	{	
		public var sample:String = 
			(<![CDATA[

			primitives {
				property-string: a test string;
				property-number: 10;
				property-float: 1.67;
				property-true: true;
				property-false: false;
				property-null: null;
				property-undefined: undefined;
				property-nan: NaN;
				property-array: apples|10|3.14|true;
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>CssPrimitiveTest</code> instance.
		*/ 
		public function CssPrimitiveTest()
		{
			super();
		}
		
		[Test]
		public function cssPrimitiveTest():void
		{
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var style:Object = stylesheet.getStyle( "primitives" );
			
			Assert.assertEquals( "a test string", style.propertyString );
			Assert.assertEquals( 10, style.propertyNumber );
			Assert.assertEquals( 1.67, style.propertyFloat );
			Assert.assertTrue( style.propertyTrue );
			Assert.assertFalse( style.propertyFalse );
			Assert.assertNull( style.propertyNull );
			Assert.assertTrue( style.propertyUndefined == undefined );
			Assert.assertTrue( isNaN( style.propertyNan ) );
			Assert.assertTrue( style.propertyArray is Array );
			Assert.assertEquals( 4, style.propertyArray.length );
			Assert.assertEquals( "apples", style.propertyArray[ 0 ] );
			Assert.assertEquals( 10, style.propertyArray[ 1 ] );
			Assert.assertEquals( 3.14, style.propertyArray[ 2 ] );
			Assert.assertEquals( true, style.propertyArray[ 3 ] );
		}
	}
}