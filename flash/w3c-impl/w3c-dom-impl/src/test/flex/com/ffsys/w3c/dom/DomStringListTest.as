package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import org.w3c.dom.DOMStringList;
	
	import com.ffsys.w3c.dom.DOMStringListImpl;
	
	/**
	*	Unit tests for manually creating string list implementations.
	*/ 
	public class DomStringListTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomStringListTest</code> instance.
		*/ 
		public function DomStringListTest()
		{
			super();
		}
		
		[Test]
		public function testStringList():void
		{
			var list:DOMStringList = new DOMStringListImpl( "a", "b", "c" );
			Assert.assertNotNull( list );
			Assert.assertEquals( 3, list.length );
			
			Assert.assertTrue( list.contains( "a" ) );
			Assert.assertTrue( list.contains( "b" ) );
			Assert.assertTrue( list.contains( "c" ) );
			Assert.assertFalse( list.contains( "d" ) );
			
			Assert.assertEquals( "a", list.item( 0 ) );
			Assert.assertEquals( "b", list.item( 1 ) );
			Assert.assertEquals( "c", list.item( 2 ) );
			
			Assert.assertEquals( "a", list[ 0 ] );
			Assert.assertEquals( "b", list[ 1 ] );
			Assert.assertEquals( "c", list[ 2 ] );
		}
	}
}