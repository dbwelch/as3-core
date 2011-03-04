package com.ffsys.utils.primitives
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for <code>PrimitivesUtilsTest</code>.
	*/ 
	public class PrimitivesUtilsTest
	{
		/**
		*	Creates a <code>PrimitivesUtilsTest</code> instance.
		*/ 
		public function PrimitivesUtilsTest()
		{
			super();
		}
		
		[Test]
		public function primitivesParseTest():void
		{
			var parser:PrimitiveParser = new PrimitiveParser();
			
			var nullValue:String = "null";
			Assert.assertNull( parser.parse( nullValue ) );
			
			var nanValue:String = "NaN";
			Assert.assertTrue( isNaN( parser.parse( nanValue ) ) );
			
			var undefinedValue:String = "undefined";
			Assert.assertTrue( parser.parse( undefinedValue ) == undefined );
			
			var intValue:String = "10";
			Assert.assertTrue( parser.parse( intValue ) == 10 );
			
			var floatValue:String = "1.67";
			Assert.assertTrue( parser.parse( floatValue ) == 1.67 );
			
			var stringValue:String = "a test string";
			Assert.assertTrue( parser.parse( stringValue ) == "a test string" );
			
			var trueValue:String = "true";
			Assert.assertTrue( parser.parse( trueValue ) );
			
			var falseValue:String = "false";
			Assert.assertTrue( !parser.parse( falseValue ) );
			
			var arrayValue:String = "apples, oranges, pears, 10";
			var fruit:Array = parser.parse( arrayValue, true );
			Assert.assertTrue( fruit.length == 4 );
			Assert.assertEquals( "apples", fruit[ 0 ] );
			Assert.assertEquals( "oranges", fruit[ 1 ] );
			Assert.assertEquals( "pears", fruit[ 2 ] );
			Assert.assertTrue( fruit[ 3 ] is int && fruit[ 3 ] == 10 );
		}
	}
}