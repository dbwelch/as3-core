package com.ffsys.scanner
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.scanner.*;
	import com.ffsys.pattern.*;
	
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
		
		[Test]
		public function patternCompileTest():void
		{	
			//pattern to match a UK mobile number
			//with optional leading zero
			var re:RegExp = /^[0-9]{10,11}$/;
			var source:String = re.source;
			var ptn:Pattern = new Pattern( re, true );
			var xml:XML = ptn.xml;
			Assert.assertEquals( source, ptn.source );
			Assert.assertEquals( source, ptn.toString() );
			Assert.assertEquals( source, ptn.regex.source );
			Assert.assertEquals( source, xml.source.text()[0] );
			
			trace("PatternTest::patternCompileTest()", ptn, ptn.test( 07900123456 ) );
			
			//simple string validation
			Assert.assertTrue( ptn.test( "07900123456" ) );
			
			//uint validation
			Assert.assertTrue( ptn.test( 07900123456 ) );
			
			ptn = new Pattern( /^[0-9]+$/, true );
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
			
			var candidates:Array = [ 201, 505 ];
			
			//	"^(?P<abc>100|201|404)25?[1-25]*$"
			
			ptn = new Pattern( new RegExp( "^((?P<id>[0-9]+|false)|(^(?:100|201|404(505)+?3000[0-1]+4000)(?P<property>myName)25?[^1-25]*[a-z]{10,)?(alpha+numeri(c|k)?)+)$" ), true );
			
			XML.prettyPrinting = true;
			XML.prettyIndent = 2;
			
			trace("[STRING TEST] PatternTest::cssTokenizeTest()",
				"303", ptn.test( "303" ) );
			trace("[INT TEST] PatternTest::cssTokenizeTest()",
				"303", ptn.test( 303 ) );
			trace("[BOOLEAN TEST] PatternTest::cssTokenizeTest()",
				"true", ptn.test( true ) );
			trace("[BOOLEAN TEST] PatternTest::cssTokenizeTest()",
				"false", ptn.test( false ) );
			trace("[OBJECT PROPERTY TEST] PatternTest::cssTokenizeTest()",
				"{ id: 303 }", ptn.test( { id: 303 } ) );

			trace("[PATTERN] PatternTest::pattern()", ptn );
			trace("[COMPILED] PatternTest::pattern()", ptn.compiled );
			trace("[SOURCE] PatternTest::pattern()", ptn.source );
			trace("[PATTERNS] PatternTest::pattern()", ptn.length, ptn.patterns );
			trace("[PARTS] PatternTest::pattern()", ptn.parts );
			trace("[POSITIONS] PatternTest::pattern()", ptn.positions );
			//trace("[RESULTS] PatternTest::pattern()", ptn.results );
			trace("[XML] PatternTest::pattern()", ptn.xml.toXMLString() );
			
			/*
			var tkn:Token = null;
			for each( tkn in results )
			{
				//trace("PatternTest::cssTokenizeTest()", tkn.id, tkn.matched );
				
				trace( tkn );
			}
			*/
			
			//trace("PatternTest::cssTokenizeTest()", /^(u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?)/.test( "u+0080-ffff" ) );
			
			//trace( /[\u000A]/.test( "\n" ), /[\u000A-\u000B]/.test( String.fromCharCode( 11 ) ) );
		}
	}
}