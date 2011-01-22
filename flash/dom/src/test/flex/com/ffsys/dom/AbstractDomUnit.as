package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.net.sax.*;
	
	import com.ffsys.dom.xhtml.*;	
	
	/**
	*	Abstract super class for DOM unit tests.
	*/
	public class AbstractDomUnit extends Object
	{
		public static const TIMEOUT:Number = 10000;
		
		public var impl:DOMImplementation;
		public var document:Document = null;
		public var parser:DomSaxParser;
		
		/**
		* 	@private
		*/
		protected var _time:Number;
		
		/**
		*	Creates a <code>AbstractDomUnit</code> instance.
		*/ 
		public function AbstractDomUnit()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_time = new Date().getTime();
			impl = new DOMImplementation();	
			parser = impl.parser();
		}
		
		[After]
     	public function tearDown():void
		{
			impl = null;
			document = null;
			parser = null;
		}
		
		protected function performActionscriptQueryAssertions():void
		{
			//document = parser.dom;
			var elements:NodeList = null;
			var child:Node;

			//should only be one registered DOM implementation
			Assert.assertEquals( 1, $().doms.length );

			//verify document language
			Assert.assertEquals( "en", $( document ).attr( "lang" ) );

			//verify processing instruction to omit DOM elements
			Assert.assertNull( document.getElementById( "html-only" ) );
			Assert.assertNull( document.getElementById( "html-only-paragraph" ) );
			//but the parent element should still exist in the DOM

			Assert.assertTrue( document.getElementById( "footer" ) is DivElement );

			//assertions on dot style node list access
			//this style of element access is supported but jquery
			//style element access is preferred and recommended as
			//it is more flexible as a DOM changes
			var list:NodeList = document.body.div[ 0 ].div[ 0 ].div[ 1 ].ul[ 0 ].li[ 0 ].a as NodeList;
			Assert.assertNotNull( list );
			Assert.assertEquals( 2, list.length );
			Assert.assertTrue( list[ 0 ] is AnchorElement );
			Assert.assertTrue( list[ 1 ] is AnchorElement );

			//matches all elements in all registered DOM implementations
			//elements = $();
			//elements = $( "*" );

			//match by tag name
			//matching the two main divs within the body tag
			elements = $( "div" );
			Assert.assertEquals( 5, elements.length );

			elements = document.getElementsByTagName( "div" );
			Assert.assertEquals( 5, elements.length );

			//match by regular expression test against element id
			elements = $( /^inner/ );
			Assert.assertEquals( 3, elements.length );

			//match by mutiple class expression
			elements = $( ".border, .single" );
			Assert.assertEquals( 3, elements.length );

			//match by identifier chain
			//elements = $( "#inner" ).find( "#inner-element-a" );
			//Assert.assertEquals( 1, elements.length );

			/*

			$( document.body ).addClass( "test-css-class" );

			*/

			$( "a" ).click(
				function( e:Event, ...parameters ):*
				{
					//trace("[CLICK INVOKED]", this, this.id, e, parameters );
				}, "a string", 10, { property: 1.67 } ).click();

			//match by descendant selector
			elements = $( "#inner-element-b ul li a" );
			Assert.assertEquals( 4, elements.length );
			Assert.assertTrue( elements[ 0 ] is AnchorElement );
			Assert.assertTrue( elements[ 1 ] is AnchorElement );
			Assert.assertTrue( elements[ 2 ] is AnchorElement );
			Assert.assertTrue( elements[ 3 ] is AnchorElement );

			//match by class name selector and descendant selector
			elements = $( ".special-paragraph a" );
			Assert.assertEquals( 2, elements.length );
			Assert.assertTrue( elements[ 0 ] is AnchorElement );
			Assert.assertTrue( elements[ 1 ] is AnchorElement );

			//match by identifier and descendant selector
			elements = $( "#alternative-navigation li a" );
			Assert.assertEquals( 2, elements.length );
			Assert.assertTrue( elements[ 0 ] is AnchorElement );
			Assert.assertTrue( elements[ 1 ] is AnchorElement );

			elements = $( "#inner-element-b p" );
			Assert.assertEquals( 2, elements.length );
			Assert.assertTrue( elements[ 0 ] is ParagraphElement );
			Assert.assertTrue( elements[ 1 ] is ParagraphElement );

//			trace("[DESCENDANT] SimpleDOMTest::domTest()", elements );

			//match by multiple selector
			elements = $( "h1, em, strong" );

//			trace("[MULTIPLE INLINE] SimpleDOMTest::domTest()", elements );	

			//test the character data api
			var cd:CharacterData = new CharacterData();
			cd.data = "This is some text";
			Assert.assertEquals( 4, cd.substringData( 0, 4 ).length );
			Assert.assertEquals( "This", cd.substringData( 0, 4 ) );
			cd.appendData( " for you" );
			Assert.assertEquals( "This is some text for you", cd.data );
			cd.insertData( 12, " new" );
			Assert.assertEquals( "This is some new text for you", cd.data );
			cd.deleteData( 12, 4 );
			Assert.assertEquals( "This is some text for you", cd.data );

			/*
			//iterate over characters and their character codes
			for( var z:String in cd )
			{
				trace("[FOR IN] SimpleDOMTest::domTest()", z, cd[ z ] );
			}

			//iterate over just the character codes
			for each( var u:uint in cd )
			{
				trace("[FOR EACH] SimpleDOMTest::domTest()", u );
			}

			//loop sequentially over the characters
			for( var i:int = 0;i < cd.length;i++ )
			{
				trace("[FOR] SimpleDOMTest::domTest()", cd[ i ] );
			}
			*/

			//modify an attribute for multiple elements at once
			$( "p" ).attr( "title", "a new title" );
			elements = $( "p" );
			for each( child in elements )
			{
				Assert.assertEquals( "a new title", child.getAttribute( "title" ) );
			}

			//trace("SimpleDOMTest::domTest()", getTestDocument() );

			//trace("SimpleDOMTest::domTest()", document.head.meta[ 0 ].httpEquiv );
			
			elements = $( "div[class][name$='man']" );
			
			trace("AbstractDomUnit::performActionscriptQueryAssertions() [GOT ATTR SELECTOR ELEMENTS]", elements );

			//trace( document.xml.toXMLString() );
			
			trace("[TEST COMPLETE] Completed DOM test in ", (  (new Date().getTime() - _time ) / 1000 )  + " seconds" );			
		}
		
		protected function loaded(
			event:Event = null, data:Object = null ):void
		{
			//
		}
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}