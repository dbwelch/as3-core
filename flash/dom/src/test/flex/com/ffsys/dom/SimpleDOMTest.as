package com.ffsys.dom
{
	import flash.events.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import asquery.*;
	
	import com.ffsys.dom.xhtml.*;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class SimpleDOMTest extends Object
	{
		/**
		*	Creates a <code>SimpleDOMTest</code> instance.
		*/ 
		public function SimpleDOMTest()
		{
			super();
			XML.ignoreComments = false;
			XML.ignoreProcessingInstructions = false;
			XML.ignoreWhitespace = false;
			XML.prettyIndent = 0;
			XML.prettyPrinting = false;					
		}
		
		/*
		
			<!DOCTYPE html PUBLIC 
				"-//W3C//DTD XHTML Basic 1.1//EN"
				"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	
		
		*/

		private function getTestDocument():XML
		{
			var x:XML =
				<html id="document" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">	
					<head>
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
									<p>
										another paragraph for you to not bother reading.
									</p>
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
		
		/*
		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
		    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">		
		
		*/
		
		[Test]
		public function domTest():void
		{
			var document:Document = null;
			
			//register an onload closure
			$( function():void
			{
				trace("[DOM ONLOAD CLOSURE HANDLER] SimpleDOMTest::domTest()", this );
				trace("[PRIMARY DOCUMENT] SimpleDOMTest::domTest()", $().document );
			} );
			
			/*
			var source:XML = getTestDocument();
			var parser:DomSaxParser = new DomSaxParser();
			parser.document = new XhtmlBeanDocument();
			parser.parse( source );
			*/
			
			var impl:DOMImplementation = new DOMImplementation();
			document = impl.parse( getTestDocument() );
			
			//trace("SimpleDOMTest::domTest()", document.xml, document.xml.@["xml:lang"] );
			
			//return;
			
			//document = parser.dom;
			var elements:NodeList = null;
			
			//should only have one registered DOM
			Assert.assertEquals( 1, $().doms.length );
			
			//verify processing instruction to omit DOM elements
			Assert.assertNull( document.getElementById( "html-only" ) );
			Assert.assertNull( document.getElementById( "html-only-paragraph" ) );
			//but the parent element should still exist in the DOM
			
			trace("SimpleDOMTest::domTest() [GOT FOOTER]", document.getElementById( "footer" ) );
			
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
			
			//match by tag name - all statements are equivalent
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
			
			trace("[MULTIPLE SELECTOR] SimpleDOMTest::domTest()", elements );
			
			$( document.body ).addClass( "test-css-class" );
			
			trace("SimpleDOMTest::domTest()", document.body.classNames );
			*/
			
			$( "a" ).click(
				function( e:Event, ...parameters ):*
				{
					trace("[CLICK INVOKED]", this, this.id, e, parameters );
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
			
			trace("[DESCENDANT] SimpleDOMTest::domTest()", elements );
			
			//match by multiple selector
			elements = $( "h1, em, strong" );
			
			trace("[MULTIPLE INLINE] SimpleDOMTest::domTest()", elements );	
			
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
			
			
			/*

			trace("SimpleDOMTest::domTest()", elements, elements[ 0 ] );
			
			$( "#inner" ).find( "#inner-element-a" ).addClass( "runtime-css-class" );
			
			trace("SimpleDOMTest::domTest()", document.body.div[ 0 ].div[ 0 ].div[ 1 ].p[ 0 ].a );
			
			trace( "[BY TAG NAME]", document.body.getElementsByTagName( "div" ) );
			*/
			
			//Assert.assertTrue( elements[ 0 ] );
			
			//match by tag name
			//elements = $( "div" );
			
			//var elements:Object = $( "#inner .border" );
			
			
			//trace("SimpleDOMTest::domTest()", elements );
			
			//trace("SimpleDOMTest::domTest()", "GOT DOM dom/length: ", document, document.length, document.head.length, document.body.length, document.inner.classes );
			
			//trace( $( ".links" ) );
		}
	}
}