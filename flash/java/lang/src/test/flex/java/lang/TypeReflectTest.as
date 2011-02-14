package java.lang
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	* 	
	*/
	public class TypeReflectTest extends Object
	{	
		/**
		* 	Creates a <code>TypeReflectTest</code> instance.
		*/
		public function TypeReflectTest()
		{
			super();
		}
		
		/**
		* 	Declared so that meta data declarations
		* 	can also be reflected on this test case.
		*/
		[Test(expects="Error")]
		public function meta():void
		{
			throw new Error( "error" );
		}
		
		[Test]
		public function testReflectedVectorType():void
		{
			var v:Object = T.vector( Array );
			Assert.assertTrue( v is Vector.<Array> );
			Assert.assertFalse( v is Vector.<Object> );
			Assert.assertFalse( v is Vector.<int> );
		}
		
		[Test]
		public function testType():void
		{
			trace("[VEC TEST] TypeReflectTest::testType()", T.vector( Array ) is Vector.<Array> );
			
			var t:T = T.getInstance( this );
			Assert.assertNotNull( t );
				
			var nt:T = T.getInstance( this );
			
			for( var z:String in t.definition )
			{
				trace("TypeReflectTest::testType()", z, t.definition[ z ] );
			}
		}
	}
}