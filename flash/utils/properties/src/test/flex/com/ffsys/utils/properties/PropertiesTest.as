package com.ffsys.utils.properties
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for <code>com.ffsys.utils.properties</code>.
	*/ 
	public class PropertiesTest
	{
		private var _expectedMultiline:String = (<![CDATA[A multiline string with hard
line breaks so that we can check
that forced hard line breaks
work as expected.]]>).toString();

		private var _expectedEndMultiline:String = (<![CDATA[A multiline string as the final property
entry so that we can check
that forced hard line breaks
work as expected at the end of a document.]]>).toString();
		
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
			properties += "		" + "\n";
			properties += "#this is a comment" + "\n";
			properties += "	#this is another comment with leading whitespace" + "\n";
			properties += "toplevel=a test top level string" + "\n";
			properties += "group.a=abc" + "\n";
			properties += "group.b=bcd" + "\n";
			properties += "group.nested.a=abcdef" + "\n";
			properties += "group.nested.b=bcdefg" + "\n";
			properties += "group.err=An error of type {0} occured" + "\n";
			properties += "multiline=A multiline string with hard\\" + "\n";
			properties += "line breaks so that we can check\\" + "\n";
			properties += "that forced hard line breaks\\" + "\n";
			properties += "work as expected." + "\n";
			properties += "after.multiline=Another message after the multiline message." + "\n";
			properties += "end.multiline=A multiline string as the final property\\" + "\n";
			properties += "entry so that we can check\\" + "\n";
			properties += "that forced hard line breaks\\" + "\n";
			properties += "work as expected at the end of a document." + "\n";			
			
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
			
			//assert on fully qualified path lookup
			Assert.assertEquals(
				"a test top level string",
				properties.getProperty( "toplevel" ) );
				
			Assert.assertEquals(
				"abc",
				properties.getProperty( "group.a" ) );					
				
			Assert.assertEquals(
				"bcd",
				properties.getProperty( "group.b" ) );				
				
			Assert.assertEquals(
				"abcdef",
				properties.getProperty( "group.nested.a" ) );
				
			Assert.assertEquals(
				"bcdefg",
				properties.getProperty( "group.nested.b" ) );
				
			Assert.assertEquals(
				"An error of type critical occured",
				properties.getProperty( "group.err", "critical" ) );
				
			Assert.assertEquals(
				_expectedMultiline, properties.getProperty( "multiline" ) );
				
			Assert.assertEquals( "Another message after the multiline message.",
			 	properties.getProperty( "after.multiline" ) );
			
			Assert.assertEquals(
				_expectedEndMultiline, properties.getProperty( "end.multiline" ) );
		}
	}
}