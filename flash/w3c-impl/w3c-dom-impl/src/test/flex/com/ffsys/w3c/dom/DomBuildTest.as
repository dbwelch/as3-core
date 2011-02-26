package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.*;
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
	
	/**
	*	Unit tests for manually constructing DOM hierarchies.
	*/ 
	public class DomBuildTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomBuildTest</code> instance.
		*/ 
		public function DomBuildTest()
		{
			super();
		}
		
		[Test]
		public function testBuildDom():void
		{
			//
			XML.ignoreComments = false;
			XML.ignoreProcessingInstructions = false;
			XML.ignoreWhitespace = false;
			
			var i:int = 0;
			var doc:Document = getXMLDocument();
			var el:Element = doc.documentElement;
			Assert.assertNotNull( el );
			
			var nm:String = "graphics";
			
			//rename the root element
			doc.renameNode( el, null, nm );
			
			Assert.assertEquals( nm, el.tagName );
			Assert.assertEquals( nm, el.nodeName );
			
			//now rename to a fully qualified name
			doc.renameNode(
				el,
				"http://example.org/graphics",
				"example:graphics" );
				
			Assert.assertFalse( el.hasChildNodes() );
			//with no children we can still retrieve an
			//empty node list implementation
			Assert.assertNotNull( el.childNodes );
			
			//add a child element
			var rect:Element = doc.createElement( "rect" );
			rect.setAttribute( "width", "20" );
			rect.setAttribute( "height", "20" );
			el.appendChild( rect );
			
			Assert.assertTrue( el.hasChildNodes() );
			Assert.assertEquals( 1, el.childNodes.length );
			
			//"rect" - should be first and last child
			Assert.assertEquals( rect, el.firstChild );
			Assert.assertEquals( rect, el.lastChild );

			Assert.assertNull( el.firstChild.previousSibling );
			Assert.assertNull( el.firstChild.nextSibling );
			
			var circle:Element = doc.createElement( "circle" );
			circle.setAttribute( "radius", "10" );
			el.appendChild( circle );
			Assert.assertEquals( 2, el.childNodes.length );
			Assert.assertEquals( "circle", circle.tagName );
			Assert.assertEquals( "circle", circle.nodeName );
			
			//"rect" - should be first and now "circle" is last child
			Assert.assertEquals( rect, el.firstChild );
			Assert.assertEquals( circle, el.lastChild );
			
			var cdata:CDATASection = doc.createCDATASection( "This is a cdata section." );
			el.appendChild( cdata );
			Assert.assertEquals( 3, el.childNodes.length );
			Assert.assertEquals( cdata, el.lastChild );
			Assert.assertEquals( "This is a cdata section.", cdata.data );
			
			var comment:Comment = doc.createComment( "This is a comment." );
			el.appendChild( comment );
			Assert.assertEquals( 4, el.childNodes.length );			
			Assert.assertEquals( comment, el.lastChild );
			Assert.assertEquals( "This is a comment.", comment.data );			
			
			var txt:Text = doc.createTextNode( "This is a plain text node." );
			el.appendChild( txt );
			Assert.assertEquals( 5, el.childNodes.length );
			Assert.assertEquals( txt, el.lastChild );
			Assert.assertEquals( "This is a plain text node.", txt.data );
			
			var ellipse:Element = doc.createElement( "ellipse" );
			ellipse.setAttribute( "width", "10" );
			ellipse.setAttribute( "height", "20" );
			el.appendChild( ellipse );
			Assert.assertEquals( 6, el.childNodes.length );

			Assert.assertEquals( "ellipse", ellipse.tagName );
			Assert.assertEquals( "ellipse", ellipse.nodeName );	
			
			//now test the element traversal methods with intermediary
			//non-element nodes - ElementTraveral implementation
			Assert.assertEquals( 3, el.childElementCount );
			
			//first element child should be the rect
			Assert.assertEquals( rect, el.firstElementChild );
			
			//last element child should be the ellipse
			Assert.assertEquals( ellipse, el.lastElementChild );
			
			//the root element should not have values for these
			//element traversal properties - according to the XML one root element rule			
			Assert.assertNull( el.previousElementSibling );
			Assert.assertNull( el.nextElementSibling );	
			
			//but if we inspect the circle we should have valid values
			Assert.assertEquals( rect, circle.previousElementSibling );
			Assert.assertEquals( ellipse, circle.nextElementSibling );
			
			trace( NodeImpl( doc ).xml.toXMLString() );
			
		}
	}
}