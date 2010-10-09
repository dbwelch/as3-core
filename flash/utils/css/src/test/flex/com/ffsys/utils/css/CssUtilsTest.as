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
			out += "}";
			
			return out;
		}
		
		[Test]
		public function cssParseTest():void
		{
			var collection:CssStyleCollection = 
				new CssStyleCollection();
				
			trace("CssUtilsTest::cssParseTest(), ", collection );
				
			collection.parseCSS( getTestCss() );
			
			var style:Object = collection.getStyle( "test-style" );
			
			trace("CssUtilsTest::cssParseTest(), ", collection.styleNames );
			trace("CssUtilsTest::cssParseTest(), ", style );
			
			for( var z:String in style )
			{
				trace("CssUtilsTest::cssParseTest(), ", z + " || " + style[ z ] );
				trace("CssUtilsTest::cssParseTest(), ", getQualifiedClassName( style[ z ] ) );
			}
			
		}
	}
}