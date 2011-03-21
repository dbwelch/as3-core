package org.flashx.utils.properties
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for primitive properties.
	*/
	public class PropertiesOverrideTest
	{
		private var _properties:String = (<![CDATA[
string=hello world
number=10
float=1.67
booleanTrue=true
booleanFalse=false
array=16,hello array world,true
nested.message=apples]]>).toString();

		private var _override:String = (<![CDATA[
string=hello override world
number=10
float=1.67
booleanTrue=true
booleanFalse=false
array=16,hello array world,true
nested.message=oranges]]>).toString();
			
		/**
		*	Creates a <code>PropertiesOverrideTest</code> instance.
		*/ 
		public function PropertiesOverrideTest()
		{
			super();
		}
		
		[Test]
		public function primitivePropertiesParseTest():void
		{
			var properties:PrimitiveProperties = new PrimitiveProperties();
			properties.parse( _properties );
			Assert.assertEquals(
				"hello world",
				properties.string );
			Assert.assertEquals(
				10,
				properties.number );
			Assert.assertEquals(
				1.67,
				properties.float );
			Assert.assertTrue( properties.booleanTrue );
			Assert.assertFalse( properties.booleanFalse );
			Assert.assertTrue( properties.array is Array );
			
			var arr:Array = properties.array as Array;
			Assert.assertEquals( 3, arr.length );
			Assert.assertEquals( 16, arr[ 0 ] );
			Assert.assertEquals( "hello array world", arr[ 1 ] );
			Assert.assertEquals( true, arr[ 2 ] );
			
			properties.parse( _override );
			Assert.assertEquals(
				"hello override world",
				properties.string );
				
			Assert.assertEquals(
				"oranges",
				properties.nested.message );
		}
	}
}