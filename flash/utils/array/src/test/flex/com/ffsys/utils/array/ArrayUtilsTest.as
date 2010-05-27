package com.ffsys.utils.array
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for <code>ArrayUtilsTest</code>.
	*/ 
	public class ArrayUtilsTest
	{
		
		/**
		*	Creates an <code>ArrayUtilsTest</code> instance.
		*/ 
		public function ArrayUtilsTest()
		{
			super();
		}
		
		/**
		*	Tests the <code>contains</code> method.
		*/
		[Test]
		public function testArrayContains():void
		{
			var obj:Object = {};
			var contents:Array = [ 1.1, "string", false, obj ];
			
			Assert.assertTrue( ArrayUtils.contains( contents, 1.1 ) );
			Assert.assertTrue( ArrayUtils.contains( contents, "string" ) );
			Assert.assertTrue( ArrayUtils.contains( contents, false ) );
			Assert.assertTrue( ArrayUtils.contains( contents, obj ) );
			
			var test:Object = {};
			Assert.assertTrue( !ArrayUtils.contains( contents, 3.14 ) );
			Assert.assertTrue( !ArrayUtils.contains( contents, "nonexistent" ) );
			Assert.assertTrue( !ArrayUtils.contains( contents, test ) );
		}
	}
}