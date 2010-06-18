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
		*	Tests the string collection.
		*/
		[Test]
		public function testStringCollection():void
		{
			var z:String = null;
			
			var collection:StringCollection = new StringCollection();
			
			//DYNAMIC ACCESS AND ENUMERATION
			collection.key = "test";
			
			Assert.assertEquals( 1, collection.length );
			Assert.assertEquals( "test", collection.key );
			
			//test enumerating values
			for each( z in collection )
			{
				Assert.assertEquals( "test", z );
			}
			
			//test enumerating keys
			for( z in collection )
			{
				Assert.assertEquals( "key", z );
			}
			
			var deleted:Boolean = delete collection[ "key" ];
			Assert.assertTrue( deleted );
			
			//API AND CHILD COLLECTIONS
			collection.key = "test";
			collection.child = new StringCollection();
			Assert.assertNotNull( collection.getStringCollectionById( "child" ) );
		}
		
		/**
		*	Tests the string collection errors on invalid boolean type.
		*/
		[Test(expects="TypeError")]
		public function testStringCollectionFailOnBoolean():void
		{
			var collection:StringCollection = new StringCollection();
			collection.boolean = true;
		}
		
		/**
		*	Tests the string collection errors on invalid object type.
		*/
		[Test(expects="TypeError")]
		public function testStringCollectionFailOnObject():void
		{
			var collection:StringCollection = new StringCollection();
			collection.object = new Object();
		}		
	}
}