package com.ffsys.dom
{
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
		
		public function get sample():XML
		{
			return <object
				id="root"
				xmlns="http://example.com/sample"
				xmlns:ui="http://example.com/nested-sample">
				text
	            <!-- comment -->
	            <?instruction ?>
				<string>
					this is a <em>test</em> string
				</string>
				<booleanTrue>true</booleanTrue>
				<booleanFalse>false</booleanFalse>
				<nullValue>null</nullValue>
				<integerValue>10</integerValue>
				<floatValue>1.67</floatValue>
				<hyphen-test>100</hyphen-test>
				<nested id="my-identifier">
					<child><![CDATA[This is some character data]]></child>
					<ui:button />
				</nested>
			</object>;
		}
		
		
		private function getTestDocument( namespaceURI:String, qualifiedName:String ):XML
		{
			var x:XML =
				<html id="document">
					<head>
					</head>
					<body id="body">
						<div id="outer">
							<div id="inner" class="border background">
								<div id="inner-element-a" class="border red" />
								<div id="inner-element-b">
									<p>
										<a href="http://google.com" title="This is a link">Some text</a>
									</p>
								</div>
							</div>
						</div>
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
			var elements:ActionscriptQuery = null;
			
			//should only have one registered DOM
			Assert.assertEquals( 1, $().doms.length );
			
			//assertions on dot style node list access
			//this style access is supported but jquery
			//style access is preferred and recommended as
			//it is more flexible as a DOM changes
			var list:NodeList = document.body.div[ 0 ].div[ 0 ].div[ 1 ].p[ 0 ].a as NodeList;
			Assert.assertNotNull( list );
			Assert.assertEquals( 1, list.length );
			Assert.assertTrue( list[ 0 ] is AnchorElement );
			
			//matches all elements in all registered DOM implementations
			//elements = $();
			//elements = $( "*" );
			
			//match by regular expression test against element id
			//elements = $( /^inner/ );
			
			//match by class expression
			//elements = $( ".border" );
			
			//match by identifier
			elements = $( "#inner" ).find( "#inner-element-a" );
			Assert.assertEquals( 1, elements.length );
			
			trace("SimpleDOMTest::domTest()", elements, elements[ 0 ] );
			
			$( "#inner" ).find( "#inner-element-a" ).addClass( "runtime-css-class" );
			
			trace("SimpleDOMTest::domTest()", document.body.div[ 0 ].div[ 0 ].div[ 1 ].p[ 0 ].a );
			
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