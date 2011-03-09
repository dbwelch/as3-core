package java.util.regex
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import org.w3c.dom.Document;
	import org.w3c.dom.DOMImplementation;
	import org.w3c.dom.Node;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	import com.ffsys.w3c.dom.bootstrap.DOMImplementationRegistry;
	
	import java.util.regex.bootstrap.DOMPatternBootstrap;
	
	/**
	*	Unit tests for patterns.
	*/ 
	public class PatternTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>PatternTest</code> instance.
		*/ 
		public function PatternTest()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		protected function getPatternDocument():PatternDocumentImpl
		{
			if( _document != null )
			{
				return _document as PatternDocumentImpl;
			}
			
			var impl:DOMImplementation = getPatternImplementation();
			Assert.assertTrue( impl is PatternDOMImplementationImpl );
			
			//create a plain xml document implementation
			var doc:Document = PatternDOMImplementationImpl( impl ).createPatternDocument();
			
			Assert.assertNotNull( doc );
			_document = doc;
			return _document as PatternDocumentImpl;
		}
		
		/**
		* 	@private
		*/
		protected function getPatternImplementation():DOMImplementation
		{
			//get the DOM registry
			var registry:DOMImplementationRegistry = getRegistry();
			//retrieve an implementation for "Pattern"
			var impl:DOMImplementation = registry.getDOMImplementation(
				"Pattern 3.0" );
			Assert.assertNotNull( impl );
			return impl;
		}
		
		/**
		* 	@private
		*/
		override protected function addDefaultRegistryImplementationSources(
			registry:DOMImplementationRegistry ):void
		{
			registry.addSource( new DOMPatternBootstrap() );
		}
		
		//[Test]
		public function addressValidationTest():void
		{
			default xml namespace = Pattern.NAMESPACE;
			
			var address_1:Object =
			{
				name: "Building name",
				number: "Building number",
				address1: "Address line 1",
				address2: "Address line 2",
				city: "City",
				county: "County",
				postcode: "Postal code"
			}
						
			var source:String =
				"((?P<name>\\w+( \\w+)*)"
				+ "|(?P<number>\\d+[a-zA-Z]?))" 		//alternation between name and number ’|’
				+ "(?P<address1>\\w+( \\w+)*)"
				+ "(?P<address2>\\w+( \\w+)*)?"			//added optionality to address2 ’?’
				+ "(?P<city>\\w+( \\w+)*)"
				+ "(?P<county>\\w+(alpha+ \\\\w+)\\\\+)"
				+ "(?P<postcode>)[a-zA-Z]{1,2}[0-9a-zA-Z]{1,2}( [0-9]{1,2}[a-zA-Z]{1,2})?";			
				
			//var ptn:Pattern = new Pattern( source, true );
			
			//var matched:Boolean = ptn.test( address_1 );
			
			//trace("PatternTest::addressValidationTest()", ptn.xml.toXMLString() );
		}
		
		//[Test]
		public function mobileNumberTest():void
		{
			/*
			default xml namespace = Pattern.NAMESPACE;			
			
			//pattern to match a UK mobile number
			//with optional leading zero
			var re:RegExp = /^[0-9]{10,11}$/;
			var source:String = re.source;
			var ptn:Pattern = new Pattern( re, true );
			
			//var xml:XML = ptn.xml;
			Assert.assertEquals( source, ptn.source );
			Assert.assertEquals( source, ptn.toString() );
			Assert.assertEquals( source, ptn.regex.source );
			
			//Assert.assertEquals( source, xml.source.text()[0] );
			//simple string validation
			Assert.assertTrue( ptn.test( "07900123456" ) );
			//uint validation
			Assert.assertTrue( ptn.test( 07900123456 ) );			
			*/
		}
		
		//[Test]
		public function numericValidationTest():void
		{
			/*
			default xml namespace = Pattern.NAMESPACE;
			
			var ptn:Pattern = new Pattern( /^[0-9]+$/, true );
			Assert.assertTrue( ptn.test( "100" ) );
			Assert.assertTrue( ptn.test( 100 ) );
			ptn = new Pattern( /^(true|false)$/, true );
			Assert.assertTrue( ptn.test( true ) );
			Assert.assertTrue( ptn.test( false ) );
			Assert.assertFalse( ptn.test( "TRUE" ) );
			Assert.assertFalse( ptn.test( "FALSE" ) );
			
			//define a 100-199 range
			ptn = new Pattern( /^1[0-9]{2}$/, true );
			Assert.assertTrue( ptn.test( 100 ) );
			Assert.assertTrue( ptn.test( 199 ) );
			Assert.assertFalse( ptn.test( 0 ) );
			Assert.assertFalse( ptn.test( 99 ) );
			Assert.assertFalse( ptn.test( 200 ) );
			Assert.assertFalse( ptn.test( 1024 ) );
			
			//define a float pattern
			ptn = new Pattern( /^([0-9]+)?\.[0-9]+$/, true );
			Assert.assertTrue( ptn.test( .5 ) );
			Assert.assertTrue( ptn.test( 1.67 ) );
			Assert.assertFalse( ptn.test( 16 ) );	
			*/
					
		}
		
		/**
		* 	Tests manually constructing a Pattern
		* 	DOM document.
		*/
		[Test]
		public function patternDOMTest():void
		{
			var doc:PatternDocumentImpl = getPatternDocument();
			
			//var rule:Rule = doc.createRule( "^([0-9]+)$" );
			
			var rule:Rule = doc.createRule( "^(?P<id>[^0-9]+?)$", "This is a comment about the rule." );
			
			trace("PatternTest::patternDOMTest()", rule );
			
			rule.flags = "gi";
			doc.appendChild( rule );
			
			var namespaces:Vector.<Namespace> = new Vector.<Namespace>();
			namespaces.push( Pattern.NAMESPACE );
			var x:XML = serializeToNativeXML( doc, namespaces );
			trace("PatternTest::patternDOMTest()", x.toXMLString() );
		}
		
		//[Test]
		public function patternCompileTest():void
		{	
			
			/*
			default xml namespace = Pattern.NAMESPACE;
			
			var candidates:Array = [ 201, 505 ];
			
			var ptn:Pattern = new Pattern( new RegExp( "^((?P<id>[0-9]+|false)|(^(?:100|201|404(505)+?3000[0-1]+4000)(?P<property>myName)25?[^1-25]*[a-z]{10,)?(alpha+numeri(c|k)?)+)$" ), true );	
			
			trace("[LENGTH] PatternTest::patternCompileTest()", ptn.length, ptn.childPatternCount );
			
			var node:Node = null;
			for each( node in ptn.childNodes )
			{
				trace("PatternTest::patternCompileTest()", node );
			}
			
			var file:PatternFile = PatternFile.encode( ptn );
			
			trace("[FILE] PatternTest::patternCompileTest()", file );
			*/
			
			//var ptn:Pattern = new Pattern( new RegExp( "^(?P<id>[0-9]+|false)$" ), true );
			
			//	"^(?P<abc>100|201|404)25?[1-25]*$"
			
			/*
			var ptn:Pattern = new Pattern( new RegExp( "^((?P<id>[0-9]+|false)|(^(?:100|201|404(505)+?3000[0-1]+4000)(?P<property>myName)25?[^1-25]*[a-z]{10,)?(alpha+numeri(c|k)?)+)$" ), true );
			
			XML.prettyPrinting = true;
			XML.prettyIndent = 2;
			
			trace("[STRING TEST] PatternTest::patternCompileTest()",
				"303", ptn.test( "303" ) );
			trace("[INT TEST] PatternTest::patternCompileTest()",
				"303", ptn.test( 303 ) );
			trace("[BOOLEAN TEST] PatternTest::patternCompileTest()",
				"true", ptn.test( true ) );
			trace("[BOOLEAN TEST] PatternTest::patternCompileTest()",
				"false", ptn.test( false ) );
			trace("[OBJECT PROPERTY TEST] PatternTest::patternCompileTest()",
				"{ id: 303 }", ptn.test( { id: 303 } ) );

			trace("[PATTERN] PatternTest::pattern()", ptn );
			trace("[COMPILED] PatternTest::pattern()", ptn.compiled );
			trace("[SOURCE] PatternTest::pattern()", ptn.source );
			trace("[PATTERNS] PatternTest::pattern()", ptn.length, ptn.patterns );
			trace("[PARTS] PatternTest::pattern()", ptn.parts );
			trace("[POSITIONS] PatternTest::pattern()", ptn.positions );
			//trace("[RESULTS] PatternTest::pattern()", ptn.results );
			//trace("[XML] PatternTest::pattern()", ptn.xml.toXMLString() );
			*/
		}
	}
}