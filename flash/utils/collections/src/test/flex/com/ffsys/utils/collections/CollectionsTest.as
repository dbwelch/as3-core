package com.ffsys.utils.collections
{
	import org.flexunit.Assert;
	
	import com.ffsys.utils.collections.data.*;
	import com.ffsys.utils.collections.properties.*;
	import com.ffsys.utils.collections.strings.*;

	/**
	*	Unit tests for the collections package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.05.2010
	*/
	public class CollectionsTest
	{
		
		/**
		*	Creates a <code>CollectionsTest</code> instance.
		*/ 
		public function CollectionsTest()
		{
			super();
		}
		
		/**
		*	Tests the collections package.
		*/
		[Test]
		public function testStringCollection():void
		{
			var z:String = null;
			
			var collection:IStringCollection = new StringCollection();
			collection[ "key" ] = "test";
			
			Assert.assertEquals( "test", collection[ "key" ] );
			
			for each( z in collection )
			{
				Assert.assertEquals( "test", z );
			}
			
			for( z in collection )
			{
				Assert.assertEquals( "key", z );
			}
		}
	}
}