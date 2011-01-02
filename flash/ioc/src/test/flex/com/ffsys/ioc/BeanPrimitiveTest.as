package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for bean primitive values.
	*/ 
	public class BeanPrimitiveTest extends AbstractBeanUnit
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
			assertPrimitivesBean( document );
		}
	}
}