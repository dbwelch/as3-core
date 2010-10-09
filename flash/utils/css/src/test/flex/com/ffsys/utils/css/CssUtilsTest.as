package com.ffsys.utils.css
{
	import org.flexunit.Assert;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Unit tests for <code>CssUtilsTest</code>.
	*/ 
	public class CssUtilsTest
	{
		/**
		*	Creates a <code>CssUtilsTest</code> instance.
		*/ 
		public function CssUtilsTest()
		{
			super();
		}
		
		private function getTestCss():String
		{
			var out:String = "test-style {";
			out += "property-string: a test string;";
			out += "property-number: 10;";
			out += "property-float: 1.67;";
			out += "property-true: true;";
			out += "property-false: false;";
			out += "property-null: null;";
			out += "property-undefined: undefined;";
			out += "property-nan: NaN;";
			out += "property-array: apples, 10, 3.14, true;";
			out += "property-class: class ( flash.display.Sprite );";
			out += "}";
			return out;
		}
		
		[Test]
		public function cssParseTest():void
		{
			var collection:CssStyleCollection = 
				new CssStyleCollection();
					
			collection.parseCSS( getTestCss() );
			
			var style:Object = collection.getStyle( "test-style" );
			
			for( var z:String in style )
			{
				trace( "Style: "
					+ z + " || " + style[ z ],
					getQualifiedClassName( style[ z ] ) );
			}
			
			Assert.assertEquals( "test-style", collection.styleNames[ 0 ] );
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
			Assert.assertTrue( style.propertyClass is Class );
		}
	}
}