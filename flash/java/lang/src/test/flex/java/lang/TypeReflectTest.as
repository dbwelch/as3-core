package java.lang
{
	import flash.display.*;	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	* 	
	*/
	dynamic public class TypeReflectTest extends Object
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
		public function testIntrospection():void
		{
			var tt:T = T.getInstance( T );
			Assert.assertNotNull( tt );
			for( var z:String in T )
			{
				trace("[T MIRROR] TypeReflectTest::testType()", z, T[ z ] );
			}
		}
		
		[Test]
		public function testObject():void
		{
			var s:T = T.getInstance( Sprite );
			Assert.assertNotNull( s );
			Assert.assertNotNull( Object( Sprite ).name );
			Assert.assertNotNull( Object( Sprite ).path );
			for( var z:String in Sprite )
			{
				trace("[OBJECT MIRROR] TypeReflectTest::testType()", z, Sprite[ z ] );
			}
		}
		
		[Test]
		public function testType():void
		{
			//TypeReflectTest.prototype.constructor = InnerTypeReflectTest;
			
			var o:Object = new Object();
			var o1:Object = new Object();
			var o2:Object = new Object();
			
			trace("[MEM ADDRESS 1] TypeReflectTest::testType()",
				MemoryAddress.toString( o1 ), MemoryAddress.valueOf( o1 ) );
				
			trace("[MEM ADDRESS 2] TypeReflectTest::testType()",
				MemoryAddress.toString( o2 ), MemoryAddress.valueOf( o2 ),
				MemoryAddress.valueOf( o2 ) > MemoryAddress.valueOf( o1 ),
				describeType( T ) );
				
			var tt:T = T.getInstance( T );

			var t:T = T.getInstance( this );
			Assert.assertNotNull( t );
				
			var nt:T = T.getInstance( this );
			
			for( var z:String in t.definition )
			{
				trace("TypeReflectTest::testType()", z, t.definition[ z ] );
			}
			
			//use namespace "http://adobe.com/2006/builtin";
			
			//trace("TypeReflectTest::testType()", getAliasName( String ) );			
		}
	}
}

import java.lang.TypeReflectTest;

class InnerTypeReflectTest extends TypeReflectTest {
	
	public function InnerTypeReflectTest()
	{
		trace("TypeReflectTest::InnerTypeReflectTest()",  "[INNER INSTANTIATED]");
	}
	
}