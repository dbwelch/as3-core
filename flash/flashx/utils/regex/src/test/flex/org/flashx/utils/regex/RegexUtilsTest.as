package org.flashx.utils.regex {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the regex utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class RegexUtilsTest extends Object {
		
		/**
		* 	Creates a <code>RegexUtilsTest</code> instance.
		*/
		public function RegexUtilsTest()
		{
			super();
		}
		
		/*
		public function testRegexContains():void
		{
			TestUtils.startOutput( this );
			
			var clean:String = "clean test string";
			
			Assert.assertTrue( RegexUtils.contains( "{}" ) );
			Assert.assertFalse( RegexUtils.contains( clean ) );
			
			//if the character contains a preceeding blackslash
			//the meta character is considered already escaped
			Assert.assertFalse( RegexUtils.contains( "\\{" ) );
			
			TestUtils.endOutput( this );
		}
		*/
		
		[Test]
		public function testRegexEscape():void
		{
			var clean:String = "clean test string";			
			Assert.assertEquals( RegexUtils.escape( clean ), clean );
			Assert.assertEquals( RegexUtils.escape( "{}[]" ), "\\{\\}\\[\\]" );
			Assert.assertEquals( RegexUtils.escape( "How are you?" ), "How are you\\?" );
		}
	}
}