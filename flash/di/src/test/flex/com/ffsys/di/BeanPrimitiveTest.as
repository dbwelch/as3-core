package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for css primitive values.
	*/ 
	public class BeanPrimitiveTest
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
		*	Creates a <code>BeanPrimitiveTest</code> instance.
		*/ 
		public function BeanPrimitiveTest()
		{
			super();
		}
		
		[Test]
		public function beanPrimitivesTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			
			Assert.assertNotNull( document );
			Assert.assertEquals( 1, document.length );
			
			var primitives:Object = document.getBean( "primitives" );
			Assert.assertNotNull( primitives );

			Assert.assertEquals( "a test string", primitives.propertyString );
			Assert.assertEquals( 10, primitives.propertyNumber );
			Assert.assertEquals( 1.67, primitives.propertyFloat );
			Assert.assertTrue( primitives.propertyTrue );
			Assert.assertFalse( primitives.propertyFalse );
			Assert.assertNull( primitives.propertyNull );
			Assert.assertTrue( primitives.propertyUndefined == undefined );
			Assert.assertTrue( isNaN( primitives.propertyNan ) );
			Assert.assertTrue( primitives.propertyArray is Array );
			Assert.assertEquals( 4, primitives.propertyArray.length );
			Assert.assertEquals( "apples", primitives.propertyArray[ 0 ] );
			Assert.assertEquals( 10, primitives.propertyArray[ 1 ] );
			Assert.assertEquals( 3.14, primitives.propertyArray[ 2 ] );
			Assert.assertEquals( true, primitives.propertyArray[ 3 ] );
		}
	}
}