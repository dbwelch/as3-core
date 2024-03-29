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