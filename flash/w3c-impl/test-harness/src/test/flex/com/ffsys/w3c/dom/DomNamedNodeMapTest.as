package com.ffsys.w3c.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import org.w3c.dom.Document;
	import org.w3c.dom.Element;
	import org.w3c.dom.NamedNodeMap;
	
	import com.ffsys.w3c.dom.NamedNodeMapImpl;
	
	/**
	*	Unit tests for operating on named node maps.
	*/ 
	public class DomNamedNodeMapTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomNamedNodeMapTest</code> instance.
		*/ 
		public function DomNamedNodeMapTest()
		{
			super();
		}
		
		[Test]
		public function testNamedNodeMap():void
		{
			var doc:Document = getXMLDocument();
			var a:Element = doc.createElement( "a" );
			var b:Element = doc.createElement( "b" );
			var c:Element = doc.createElement( "c" );
			
			var map:NamedNodeMapImpl = new NamedNodeMapImpl();
			map.setNamedItem( a );
			Assert.assertTrue( map.hasNamedItem( a ) );
			Assert.assertFalse( map.hasNamedItem( b ) );
			
			Assert.assertEquals( 1, map.length );
			Assert.assertEquals(
				a, map.getNamedItem( a.nodeName ) );
				
			map.setNamedItem( b );
			map.setNamedItem( c );
			
			Assert.assertEquals( 3, map.length );
			
			Assert.assertTrue( map.hasNamedItem( a ) );
			Assert.assertTrue( map.hasNamedItem( b ) );
			Assert.assertTrue( map.hasNamedItem( c ) );
			
			Assert.assertEquals(
				b, map.getNamedItem( "b" ) );
				
			//nodeName and tagName are equivalent for elements
			Assert.assertEquals(
				c, map.getNamedItem( c.tagName ) );	
		}
	}
}