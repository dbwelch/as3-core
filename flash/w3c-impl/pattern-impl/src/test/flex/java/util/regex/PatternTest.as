package java.util.regex
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.w3c.dom.Node;
	
	/**
	*	Unit tests for patterns.
	*/ 
	public class PatternTest extends Object
	{
		/**
		*	Creates a <code>PatternTest</code> instance.
		*/ 
		public function PatternTest()
		{
			super();
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
				
			var ptn:Pattern = new Pattern( source, true );
			
			var matched:Boolean = ptn.test( address_1 );
			
			trace("PatternTest::addressValidationTest()", ptn.xml.toXMLString() );
		}
		
		//[Test]
		public function mobileNumberTest():void
		{
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
		}
		
		//[Test]
		public function numericValidationTest():void
		{
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
		}
		
		[Test]
		public function patternCompileTest():void
		{	
			default xml namespace = Pattern.NAMESPACE;
			
			var candidates:Array = [ 201, 505 ];
			
			var ptn:Pattern = new Pattern( new RegExp( "^((?P<id>[0-9]+|false)|(^(?:100|201|404(505)+?3000[0-1]+4000)(?P<property>myName)25?[^1-25]*[a-z]{10,)?(alpha+numeri(c|k)?)+)$" ), true );	
			
			trace("[LENGTH] PatternTest::patternCompileTest()", ptn.length, ptn.childPatternCount );
			
			var node:Node = null;
			for each( node in ptn.childNodes )
			{
				trace("PatternTest::patternCompileTest()", node );
			}
			
			trace("PatternTest::patternCompileTest()", ptn.xml.toXMLString() );
			
			var file:PatternFile = PatternFile.encode( ptn );
			
			trace("[FILE] PatternTest::patternCompileTest()", file );
			
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