package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import org.flashx.ioc.*;
	import com.ffsys.w3c.dom.*;
	
	import com.ffsys.w3c.dom.ls.LSOutputImpl;
	
	import org.w3c.dom.*;
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.DOMImplementationLS;
	import org.w3c.dom.DOMException;
	
	/**
	*	Unit tests for manually manipulating node lists.
	*/ 
	public class DomNodeListTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomNodeListTest</code> instance.
		*/ 
		public function DomNodeListTest()
		{
			super();
		}
		
		[Test]
		public function testNodeList():void
		{
			var doc:Document = getXMLDocument();
			var el:Element = doc.createElement( "list-test" );
			doc.appendChild( el );
			var list:NodeList = el.childNodes;
			Assert.assertTrue( list is NodeListImpl );
			
			el.appendChild( doc.createElement( "a" ) );
			el.appendChild( doc.createElement( "b" ) );
			el.appendChild( doc.createElement( "c" ) );
			
			Assert.assertEquals( 3, list.length );
			Assert.assertEquals( 3, el.childNodes.length );
			
			var n:Node;
			var ln:Node;
			for( var i:int = 0;i < list.length;i++ )
			{
				n = el.childNodes[ i ];
				ln = list.item( i );
				Assert.assertNotNull( n );
				Assert.assertNotNull( ln );
				Assert.assertEquals( n, ln );
			}
			
			Assert.assertEquals( 3, i );
			
			//iterate over the node list with no specific order
			var c:int = 0;
			for each( n in list )
			{
				Assert.assertNotNull( n );
				c++;
			}
			Assert.assertEquals( 3, c );
		}
	}
}