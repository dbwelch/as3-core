package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.dom.xhtml.*;

	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Unit tests for parsing entire DOM XML documents
	* 	using the parse() method.
	*/ 
	dynamic public class DomParseTest extends AbstractDomUnit
	{
		
		public var loader:ILoader;
		
		/**
		*	Creates a <code>DomParseTest</code> instance.
		*/ 
		public function DomParseTest()
		{
			super();		
		}
		
		[Before( async )]
     	override public function setUp():void
		{
			super.setUp();
			
			loader = new XmlLoader();
			loader.request = new URLRequest( "mock-dom.html" );
			loader.addEventListener(
				LoadEvent.DATA,
				Async.asyncHandler( this, loaded, TIMEOUT, null, fail ) );
			loader.load();
		}
		
		override protected function loaded(
			event:Event = null, data:Object = null ):void
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
			
			//test parsing a partial into an existing element
			var doc:Document = new Document();
			doc.document = new XhtmlBeanDocument();
			var para:ParagraphElement = doc.createElement( "p" ) as ParagraphElement;
			para.setAttribute( "class", "border red" );
			fragment = new XML( "<span>this is some test paragraph markup to parse into an existing element</span>" );
			var result:ParagraphElement = impl.parse( fragment, null, para ) as ParagraphElement;
			Assert.assertNotNull( result );
			Assert.assertEquals( para, result );
			
			//trace("DomParseTest::setUp()", para.xml.toXMLString() );
			
			//register an onload closure
			$( function():void
			{
				trace("[DOM ONLOAD CLOSURE HANDLER] DomParseTest::domTest()", this, this.childNodes );
			} );
			
			//get the document XML markup
			var source:XML = XmlResource( LoadEvent( event ).resource ).xml;
			Assert.assertNotNull( source );
			
			//trace("DomParseTest::setUp()", source.toXMLString() );
			
			//parse the entire document
			document = Document( impl.parse( source ) );
			
			performActionscriptQueryAssertions();
		}		
		
		[Test( async )]
		public function domParseTest():void
		{	
			//
		}
	}
}