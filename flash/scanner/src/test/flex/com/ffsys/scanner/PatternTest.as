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
	dynamic public class PatternTest extends AbstractScannerUnit
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
			var candidates:Array = [ 201, 505 ];
			
			//	"^(?P<abc>100|201|404)25?[1-25]*$"
			
			var ptn:Pattern = new Pattern();
			ptn.compile(
				"^((?P<id>[0-9]+|false)|(^(?:100|201|404(505)+?3000[0-1]+4000)(?P<property>myName)25?[^1-25]*[a-z]{10,)?(alpha+numeri(c|k)?)+)$" );
			
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