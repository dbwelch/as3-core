package com.ffsys.utils.string {
	
	import flash.utils.getQualifiedClassName;
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the string utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class StringUtilsTest extends Object {
		
		static private const TEST_CAMEL_CASE:String = "carModel30";
		static private const TEST_WELCOME_STRING:String = "hello beautiful world";
		static private const TEST_DIR:String = "/path/nested/folder/images/";
		static private const TEST_EXTENSION:String = "png";
		static private const TEST_FILE_NAME:String = "my_image_name";
		static private const TEST_FULL_FILE_NAME:String = TEST_FILE_NAME + StringUtils.DOT + TEST_EXTENSION;
		static private const TEST_PATH:String = TEST_DIR + TEST_FULL_FILE_NAME;
		
		/**
		* 	Creates a <code>StringUtilsTest</code> instance.
		*/
		public function StringUtilsTest()
		{
			super();
		}
		
		[Test]
		public function testLeftTrim():void
		{
			var str:String = "\t\r\n a b c";
			str = StringUtils.ltrim( str );
			trace( "'" + str + "'" );
			Assert.assertTrue( str.length == 5 );
		}
		
		[Test]
		public function testRightTrim():void
		{
			var str:String = "a b c \t\r\n";
			str = StringUtils.rtrim( str );
			trace( "'" + str + "'" );
			Assert.assertTrue( str.length == 5 );
		}
		
		[Test]
		public function testTrim():void
		{
			var str:String = "\t\r\n a b c \t\r\n";
			str = StringUtils.trim( str );
			trace( "'" + str + "'" );
			Assert.assertTrue( str.length == 5 );		
		}
		
		[Test]
		public function testBasename():void
		{
			var str:String = TEST_PATH;
			str = StringUtils.basename( str );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, TEST_FULL_FILE_NAME );
		}
		
		[Test]
		public function testStrippedBasename():void
		{
			var str:String = TEST_PATH;
			str = StringUtils.basename( str, true );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, TEST_FILE_NAME );
		}
		
		[Test]
		public function testRemoveExtension():void
		{
			var str:String = TEST_PATH;
			str = StringUtils.removeExtension( str );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, TEST_DIR + TEST_FILE_NAME );
		}
		
		[Test]
		public function testGetExtension():void
		{
			var str:String = TEST_PATH;
			str = StringUtils.getExtension( str );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, TEST_EXTENSION );
		}
		
		[Test]
		public function testSubstitute():void
		{
			var str:String = "%s %s %s";
			str = StringUtils.substitute( str, "hello", "beautiful", "world" );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, TEST_WELCOME_STRING );
		}
		
		[Test]
		public function testRepeat():void
		{
			var len:int = 10;
			var str:String = "a";
			str = StringUtils.repeat( str, len );
			trace( "'" + str + "'" );
			Assert.assertTrue( str.length == len );
		}
		
		//TODO: reintegrate when ComplexClass is in a test-utils swc
		/*
		public function testGetClassString():void
		{
			var str:String = TestUtils.TEST_OBJECT.toString();
			str = StringUtils.getClassString( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "Object", str );
			
			str = TestUtils.TEST_COMPLEX_CLASS.toString();
			str = StringUtils.getClassString( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "ComplexClass", str );
		}
		*/
		
		[Test]
		public function testWords():void
		{
			var str:String = TEST_WELCOME_STRING;
			var arr:Array = StringUtils.words( str );
			trace( arr );
			Assert.assertTrue( arr.length == 3 );
		}
		
		[Test]
		public function testToTitleCase():void
		{
			var str:String = TEST_WELCOME_STRING;
			str = StringUtils.toTitleCase( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "Hello Beautiful World", str );
			
			str = TEST_CAMEL_CASE;
			str = StringUtils.toTitleCase( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "CarModel30", str );
		}
		
		//TODO: migrate to a separate unit test for the camel case logic
		/*
		public function testIsCamelCase():void
		{
			var str:String = TEST_CAMEL_CASE;
			Assert.assertTrue( CamelCaseUtils.isCamelCase( str ) );
			trace( "'" + str + "'" );
			Assert.assertFalse( CamelCaseUtils.isCamelCase( TEST_FILE_NAME ) );
		}
		
		public function testFromCamelCase():void
		{
			var str:String = TEST_CAMEL_CASE;
			str = CamelCaseUtils.fromCamelCase( str );
			trace( "'" + str + "'" );
			Assert.assertEquals( str, "car_model_30" );
			var back:String = CamelCaseUtils.toCamelCase( str );
			Assert.assertEquals( TEST_CAMEL_CASE, back );
		}
		
		public function testToCamelCase():void
		{
			var str:String = TEST_FILE_NAME;
			str = CamelCaseUtils.toCamelCase( str );
			trace( "'" + str + "'" );
			Assert.assertEquals( "myImageName", str );
		}
		*/
		
		[Test]
		public function testParsePackageName():void
		{
			var str:String = getQualifiedClassName( this );
			str = StringUtils.parsePackageName( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "com.ffsys.utils.string", str );
		}				
		
		[Test]
		public function testParseClassName():void
		{
			var str:String = getQualifiedClassName( this );
			str = StringUtils.parseClassName( str );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "StringUtilsTest", str );
		}
		
		[Test]
		public function testLeftStrip():void
		{
			var str:String = "[[[[abc]]]]";
			str = StringUtils.lstrip( str, "[[" );
			trace( "'" + str + "'" );
			
			Assert.assertEquals( "abc]]]]", str );
		}
		
		[Test]
		public function testRightStrip():void
		{
			var str:String = "[[[[abc]]]]";
			str = StringUtils.rstrip( str, "]]" );
			trace( "'" + str + "'" );
			Assert.assertEquals( "[[[[abc", str );
		}
		
		[Test]
		public function testStrip():void
		{
			var str:String = "????abc????";
			str = StringUtils.strip( str, "??" );
			trace( "'" + str + "'" );
			Assert.assertEquals( "abc", str );
		}
	}
}