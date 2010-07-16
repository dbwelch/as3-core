package com.ffsys.utils.properties
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for <code>com.ffsys.utils.properties</code>.
	*/ 
	public class PropertiesTest
	{
		
		/**
		*	Creates an <code>PropertiesTest</code> instance.
		*/ 
		public function PropertiesTest()
		{
			super();
		}
		
		private function getTestProperties():String
		{
			var properties:String = "";
			properties += "#this is a comment" + "\n";
			properties += "	#this is another comment with leading whitespace" + "\n";
			properties += "toplevel=a test top level string" + "\n";
			properties += "group.a=abc" + "\n";
			properties += "group.b=bcd" + "\n";
			properties += "group.nested.a=abcdef" + "\n";
			properties += "group.nested.b=bcdefg" + "\n";
			properties += "group.err=An error of type {0} occured";
			return properties;
		}
		
		[Test]
		public function propertiesParseTest():void
		{
			var properties:Properties = new Properties();
			
			properties.parse( getTestProperties() );
			
			Assert.assertEquals( "a test top level string", properties.toplevel );
			Assert.assertEquals( "abc", properties.group.a );
			Assert.assertEquals( "bcd", properties.group.b );
			
			Assert.assertEquals( "abcdef", properties.group.nested.a );
			Assert.assertEquals( "bcdefg", properties.group.nested.b );	
			
			Assert.assertTrue( properties.group is IProperties );
			Assert.assertTrue( properties.group.nested is IProperties );
			Assert.assertTrue(
				properties.getPropertiesById( "group" ) is IProperties );
			
			//
			Assert.assertEquals(
				"An error of type {0} occured", properties.group.err );
			
			//	
			Assert.assertEquals(
				"An error of type critical occured", properties.group.substitute(
					"err", [ "critical" ] ) );			
		}
	}
}