package java.util
{
	import org.flexunit.Assert;	
	
	/**
	* 	Unit tests for the Java Collections Framework implementation.
	*/
	public class CollectionTest extends Object
	{
		/**
		*	Creates a <code>CollectionTest</code> instance.
		*/
		public function CollectionTest()
		{
			super();
		}
		
		[Test]
		public function testArrayList():void
		{
			var list:ArrayList = new ArrayList();
			list.add( null );
			trace("[TEST LIST COLLECTION] CollectionTest::testArrayList()", list, list.size() );
			Assert.assertEquals( 1, list.size() );
		}		
		
		[Test]
		public function testSet():void
		{
			trace("[TEST SET COLLECTION] CollectionTest::testSet()", this );
		}
	}
}