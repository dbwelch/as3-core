package com.ffsys.utils.properties
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for string properties.
	*/ 
	public class PropertiesTest
	{
		private var _properties:String = (<![CDATA[
		
#this is a comment
	#this is another comment with leading whitespace
toplevel=a test top level string
group.a=abc
group.b=bcd
group.nested.a=abcdef
group.nested.b=bcdefg
group.err=An error of type {0} occured
multiline=A multiline string with hard\\
line breaks so that we can check\\
that forced hard line breaks\\
work as expected.
after.multiline=Another message after the multiline message.
end.multiline=A multiline string as the final property\\
entry so that we can check\\
that forced hard line breaks\\
work as expected at the end of a document.
]]>).toString();		
		
		private var _expectedMultiline:String = (<![CDATA[A multiline string with hard
line breaks so that we can check
that forced hard line breaks
work as expected.]]>).toString();

		private var _expectedEndMultiline:String = (<![CDATA[A multiline string as the final property
entry so that we can check
that forced hard line breaks
work as expected at the end of a document.]]>).toString();
		
		/**
		*	Creates a <code>PropertiesTest</code> instance.
		*/ 
		public function PropertiesTest()
		{
			super();
		}
		
		[Test]
		public function propertiesParseTest():void
		{
			var properties:Properties = new Properties();
			
			properties.parse( _properties );
			
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