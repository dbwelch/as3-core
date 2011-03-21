package org.flashx.utils.boolean {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the boolean utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class BooleanUtilsTest extends Object {
		
		/**
		* 	Creates a <code>BooleanUtilsTest</code> instance.
		*/
		public function BooleanUtilsTest()
		{
			super();
		}
		
		[Test]
		public function testStringIsBoolean():void
		{
			//must be lower case true/false to pass
			Assert.assertTrue( BooleanUtils.stringIsBoolean( "true" ) );
			Assert.assertTrue( BooleanUtils.stringIsBoolean( "false" ) );
			Assert.assertFalse( BooleanUtils.stringIsBoolean( "TRUE" ) );
			Assert.assertFalse( BooleanUtils.stringIsBoolean( "FALSE" ) );
			Assert.assertFalse( BooleanUtils.stringIsBoolean( "whatever" ) );
			Assert.assertFalse( BooleanUtils.stringIsBoolean( "0" ) );
			Assert.assertFalse( BooleanUtils.stringIsBoolean( "1" ) );
		}	
		
		[Test]
		public function testStringToBoolean():void
		{
			Assert.assertTrue( BooleanUtils.stringToBoolean( "true" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "false" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "TRUE" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "FALSE" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "whatever" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "0" ) );
			Assert.assertFalse( BooleanUtils.stringToBoolean( "1" ) );
		}			
	}
}