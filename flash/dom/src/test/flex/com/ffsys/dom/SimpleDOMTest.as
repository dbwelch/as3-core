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

		private function getTestDocument( namespaceURI:String, qualifiedName:String ):XML
		{
			var x:XML =
				<html id="document">
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
						<div id="outer" class="single">
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
									<ul>
										<li>
											<a id="test-anchor-alt1" href="http://google.com"
												title="This is a link">Some text</a>
											<a id="another-anchor-alt2" href="http://google.com"
												title="This is a another link">Some more text</a>
										</li>
									</ul>
									<p class="special-paragraph">
										This is a paragraph of text for you to read.
									</p>
								</div>
							</div>
						</div>				
						
						<div id="footer">
							<!-- A special processing instruction that indicates
								that the next sibling element should be completely
								excluded when the DOM is created -->
							<?flash-dom-exclude ?>
							<div>
								<p>some content only for html renderings</p>
							</div>
						</div>
						<a id="anchor-outside-div">a link</a>
					</body>
				</html>;
			x.@[ 'xmlns' ] = namespaceURI;
			x.@[ 'xml:lang' ] = "en";
			x.setName( qualifiedName );
			return x;
		}
		
		/*
		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
		    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">		
		
		*/
		
		[Test]
		public function domTest():void
		{
			
			//register an onload closure
			$( function():void
			{
				trace("[DOM ONLOAD CLOSURE HANDLER] SimpleDOMTest::domTest()", this );
				trace("[PRIMARY DOCUMENT] SimpleDOMTest::domTest()", $().document );
			} );
			
			var source:XML = getTestDocument( "http://www.w3.org/1999/xhtml", "html" );
			var parser:DomSaxParser = new DomSaxParser();
			parser.document = new XhtmlBeanDocument();
			parser.parse( source );

			/*
			var impl:DOMImplementation = new DOMImplementation();
			var type:DocumentType = impl.getXhtmlDocumentType();
			var document:Document = impl.createDocument( "http://www.w3.org/1999/xhtml", "html", type );
			
			trace("SimpleDOMTest::domTest()", document, document.head, document.body );
			
			var elements:Object = $( ".links" );
			*/
			
			var document:Document = parser.dom;
			var elements:NodeList = null;
			
			//should only have one registered DOM
			Assert.assertEquals( 1, $().doms.length );
			
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
			//elements = $( /^inner/ );
			//Assert.assertEquals( 3, elements.length );
			
			//match by class expression
			//elements = $( ".border" );
			
			//match by identifier chain
			//elements = $( "#inner" ).find( "#inner-element-a" );
			//Assert.assertEquals( 1, elements.length );
			
			/*
			//match by multiple selector
			elements = $( "div,a" );
			
			trace("[MULTIPLE SELECTOR] SimpleDOMTest::domTest()", elements );
			
			$( document.body ).addClass( "test-css-class" );
			
			trace("SimpleDOMTest::domTest()", document.body.classNames );
			*/
			
			$( "a" ).click(
				function( e:Event, ...parameters ):*
				{
					trace("[CLICK INVOKED]", this, this.id, e, parameters );
				}, "a string", 10, { property: 1.67 } ).click();			
			
			
			//match by class name selector and descendant selector
			elements = $( "div ul li a" );

			trace("[DESCENDANT] SimpleDOMTest::domTest()", elements );
			
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