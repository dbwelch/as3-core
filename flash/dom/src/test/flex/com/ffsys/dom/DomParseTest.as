package com.ffsys.dom
{
	import flash.events.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.dom.xhtml.*;
	
	/**
	*	Unit tests for parsing entire DOM XML documents
	* 	using the parse() method.
	*/ 
	dynamic public class DomParseTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomParseTest</code> instance.
		*/ 
		public function DomParseTest()
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
		
		[Test( async )]
		public function domTest():void
		{	
			//test parsing to a document fragment
			var fragment:XML = new XML( "<p>this is a test paragraph</p>" );
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
				trace("[DOM ONLOAD CLOSURE HANDLER] DomParseTest::domTest()", this, this.childNodes );
			} );
			
			//parse an entire document
			document = Document( impl.parse( getTestDocument() ) );
			
			performActionscriptQueryAssertions();
		}
	}
}