package com.ffsys.utils.identifier {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the identifier utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class IdentifierUtilsTest extends Object {
		
		/**
		* 	@private
		*/
		static private const TEST_PATH:String =
			"/path/nested/folder/images/my_image_name.png";
		
		/**
		* 	Creates an <code>IdentifierUtilsTest</code> instance.
		*/
		public function IdentifierUtilsTest()
		{
			super();
		}
		
		[Test]
		public function testGetBaseNameId():void
		{
			var str:String = TEST_PATH;
			var id:String = IdentifierUtils.getFileNameId( str );
			Assert.assertEquals( id, "myImageName" );
		}
		
		[Test]
		public function testGetObjectId():void
		{
			var object:Object;
			var id:String;
			
			var testId:String = "testId";
			
			object = { id: testId };
			id= IdentifierUtils.getObjectId( object );
			Assert.assertEquals( id, testId );
			
			object = { uid: testId };
			id= IdentifierUtils.getObjectId( object );
			Assert.assertEquals( id, testId );
			
			object = { name: testId };
			id= IdentifierUtils.getObjectId( object );
			Assert.assertEquals( id, testId );
			
			object = { myId: testId };
			id= IdentifierUtils.getObjectId( object );
			Assert.assertNull( id );
		}		
		
	}	
}