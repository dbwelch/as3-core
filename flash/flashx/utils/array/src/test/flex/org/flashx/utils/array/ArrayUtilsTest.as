package org.flashx.utils.array
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
		
		public function getArrayItems( id:int, maximum:int ):Array
		{
			var output:Array = new Array();
			
			var item:int;
			
			for( var i:int = 0;i < maximum;i++ )
			{
				item = ( id * 100 ) + i;
				output.push( item );
			}
			
			return output;
		}
		
		[Test]
		public function uniqueArrayTest():void
		{
			var arr:Array = "aaabbcccdef".split( "" );
			var unique:Array = new UniqueArray().unique( arr );
			
			Assert.assertEquals( 6, unique.length );
			
			Assert.assertEquals( "a", unique[ 0 ] );
			Assert.assertEquals( "b", unique[ 1 ] );
			Assert.assertEquals( "c", unique[ 2 ] );
			Assert.assertEquals( "d", unique[ 3 ] );
			Assert.assertEquals( "e", unique[ 4 ] );
			Assert.assertEquals( "f", unique[ 5 ] );
		}
		
		[Test]
		public function interleaveTest():void
		{
			var weaver:ArrayWeaver = new ArrayWeaver();
			
			var arr1:Array = getArrayItems( 1, 10 );
			var arr2:Array = getArrayItems( 2, 10 );
			var arr3:Array = getArrayItems( 3, 12 );
			
			var items:Array = weaver.interleave( arr1, arr2, arr3 );
			
			Assert.assertEquals( 32, items.length );
			
			Assert.assertEquals( 100, items[ 0 ] );
			Assert.assertEquals( 200, items[ 1 ] );
			Assert.assertEquals( 300, items[ 2 ] );
			Assert.assertEquals( 101, items[ 3 ] );
			Assert.assertEquals( 201, items[ 4 ] );
			Assert.assertEquals( 301, items[ 5 ] );
			Assert.assertEquals( 102, items[ 6 ] );
			Assert.assertEquals( 202, items[ 7 ] );
			Assert.assertEquals( 302, items[ 8 ] );
			Assert.assertEquals( 103, items[ 9 ] );
			
			Assert.assertEquals( 203, items[ 10 ] );
			Assert.assertEquals( 303, items[ 11 ] );
			Assert.assertEquals( 104, items[ 12 ] );
			Assert.assertEquals( 204, items[ 13 ] );
			Assert.assertEquals( 304, items[ 14 ] );
			Assert.assertEquals( 105, items[ 15 ] );
			Assert.assertEquals( 205, items[ 16 ] );
			Assert.assertEquals( 305, items[ 17 ] );
			Assert.assertEquals( 106, items[ 18 ] );
			Assert.assertEquals( 206, items[ 19 ] );
			
			Assert.assertEquals( 306, items[ 20 ] );
			Assert.assertEquals( 107, items[ 21 ] );
			Assert.assertEquals( 207, items[ 22 ] );
			Assert.assertEquals( 307, items[ 23 ] );
			Assert.assertEquals( 108, items[ 24 ] );
			Assert.assertEquals( 208, items[ 25 ] );
			Assert.assertEquals( 308, items[ 26 ] );
			Assert.assertEquals( 109, items[ 27 ] );
			Assert.assertEquals( 209, items[ 28 ] );
			Assert.assertEquals( 309, items[ 29 ] );
			
			Assert.assertEquals( 310, items[ 30 ] );
			Assert.assertEquals( 311, items[ 31 ] );
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