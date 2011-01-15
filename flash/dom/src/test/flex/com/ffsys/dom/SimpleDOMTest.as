package com.ffsys.dom
{
	import flash.events.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.dom.xhtml.*;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	dynamic public class SimpleDOMTest extends Object
	{
		private var _time:Number;
		
		/**
		*	Creates a <code>SimpleDOMTest</code> instance.
		*/ 
		public function SimpleDOMTest()
		{
			super();		
		}
		
		private function getTestDocument():XML
		{
			var x:XML =
				<html id="document"
					xmlns="http://www.w3.org/1999/xhtml"
					xmlns:xml="http://www.w3.org/XML/1998/namespace"
					xml:lang="en">
					<head>
						
						<![CDATA[
							A CDATA section with some character data in it.
						]]>
					
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
						<title>Example test document</title>
						<link rel="stylesheet" href="../css/reset.css" type="text/css" media="screen" />
						<link rel="stylesheet" href="../css/common.css" type="text/css" media="screen" />

						<!-- rsls -->
						<link rel="alternate" href="../swf/application-assets.swf" type="application/shockwave-flash" media="screen,flash" />

						<!-- beans -->
						<link rel="alternate" href="../css/application.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/graphic-components.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/custom-view-components.css" type="text/css" media="screen,flash" />

						<!-- flash styles -->
						<link rel="alternate" href="../css/component-styles.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/scroll-styles.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/graphic-button-styles.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/application-styles.css" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../css/filters.css" type="text/css" media="screen,flash" />

						<!-- flash images -->
						<link rel="alternate" href="../images/thumbnail-001.jpg" type="text/css" media="screen,flash" />
						<link rel="alternate" href="../images/thumbnail-002.jpg" type="text/css" media="screen,flash" />

						<!-- flash messages -->
						<link rel="alternate" href="../messages/messages.properties" type="text/plain" media="screen,flash" />
					</head>
					<body id="body">
						<!-- A COMMENT TO READ -->
						<h1>My unit test document</h1>
						<div id="outer" class="single">
							<h3>Some markup to perform tests on</h3>
							<div id="inner" class="border background">
								<div id="inner-element-a" class="border red" />
								<div id="inner-element-b">
									<ul>
										<li>
											<a id="test-anchor" href="http://google.com"
												title="This is a link">Some text</a>
											<a id="another-anchor" href="http://google.com"
												title="This is a another link">Some more text</a>
										</li>
									</ul>
									<ul id="alternative-navigation">
										<li>
											<a id="test-anchor-alt1" href="http://google.com"
												title="This is a link">Some text</a>
											<a id="another-anchor-alt2" href="http://google.com"
												title="This is a another link">Some more text</a>
										</li>
									</ul>
									<p id="test-paragraph" class="special-paragraph">
										This <em>is a paragraph</em> of text for you to read with an <a id="inline-link" href="http://google.com">inline link</a> <strong>why not</strong> have <a id="inline-alternative-link" href="http://google.com">another link</a> just to be certain.
									</p>
									<p>another paragraph for you to not bother reading.</p>
								</div>
							</div>
						</div>
						
						<div id="footer">
							<!-- A special processing instruction that indicates
								that the next sibling element should be
								excluded when the DOM is created -->
							<?flash-dom-exclude ?>
							<div id="html-only">
								<p id="html-only-paragraph">some content only for html renderings</p>
							</div>
						</div>
						<a id="anchor-outside-div">a link</a>
					</body>
				</html>;
			return x;
		}
		
		[Test]
		public function domTest():void
		{
			_time = new Date().getTime();
			
			var document:Document = null;
			
			//test parsing to a document fragment
			var fragment:XML = new XML( "<p>this is a test paragraph</p>" );
			var impl:DOMImplementation = new DOMImplementation();
			var documentFragment:DocumentFragment = impl.fragment( fragment );
			Assert.assertTrue( documentFragment is DocumentFragment );
			Assert.assertTrue( documentFragment.childNodes[ 0 ] is ParagraphElement );
			Assert.assertTrue( documentFragment.childNodes[ 0 ].childNodes[ 0 ] is Text );
				
			//test parsing a partial
			fragment = new XML( "<p class=\"partial-paragraph\">this is a test paragraph</p>" );
			var partial:ParagraphElement = impl.parse( fragment ) as ParagraphElement;
			Assert.assertNotNull( partial );
			
			Assert.assertEquals( "partial-paragraph", partial.classNames );
			Assert.assertTrue( partial.childNodes[ 0 ] is Text );
			
			//register an onload closure
			$( function():void
			{
				trace("[DOM ONLOAD CLOSURE HANDLER] SimpleDOMTest::domTest()", this, this.childNodes );
			} );
			
			/*
			var source:XML = getTestDocument();
			var parser:DomSaxParser = new DomSaxParser();
			parser.document = new XhtmlBeanDocument();
			parser.parse( source );
			*/
			
			//parse an entire document
			document = Document( impl.parse( getTestDocument() ) );
			
			//document = parser.dom;
			var elements:NodeList = null;
			var child:Node;
			
			//should only three registered DOM implementations
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
			
			trace( document.xml.toXMLString() );
			trace("[TEST COMPLETE] Completed DOM test in ", (  (new Date().getTime() - _time ) / 1000 )  + " seconds" );
		}
	}
}