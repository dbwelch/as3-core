package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.css.*;
	import com.ffsys.token.*;
	
	/**
	*	Unit tests for tokenizing css documents.
	*/ 
	dynamic public class CssTokenizerTest extends AbstractDomUnit
	{
		/**
		* 	Sample css for this unit test.
		*/
		public var sample:String = <css>
				<![CDATA[
					<!-- SOME COMMENT DATA -->
					/**/
					/* a comment with some text */
					@charset "utf-8";
					
					[media|=flash] {
						-as-custom-style: 0.5;
					}
					
					[lang~=en] {
						color: #ff6600;
					}
					
					* {
						font-size: 2.5em;
						margin-bottom: 10;
						font-family: 'Arial Narrow', Arial, sans-serif;
					}
					
					#id {
						width: 100%;
					}
				]]>
			</css>.toString();
		
		/**
		*	Creates a <code>CssTokenizerTest</code> instance.
		*/ 
		public function CssTokenizerTest()
		{
			super();
		}
		
		[Test]
		public function cssTokenizeTest():void
		{	
			var tokenizer:CssTokenizer = new CssTokenizer();
			var results:Vector.<Token> = tokenizer.parse( sample );
			
			trace("[RESULTS] CssTokenizerTest::cssTokenizeTest()", results.length );
			
			var tkn:Token = null;
			for each( tkn in results )
			{
				trace("CssTokenizerTest::cssTokenizeTest()", tkn.id, tkn.matched );
			}
			
			//trace("CssTokenizerTest::cssTokenizeTest()", /^([\-]?(([_a-zA-Z]+)|([^\\x00-\\xED])+)[_a-zA-Z0-9\-]*)/.test( "*" ) );
			
			trace("CssTokenizerTest::cssTokenizeTest()", "\n".charCodeAt( 0 ), "a".charCodeAt( 0 ) );
			
			
			var char:String = "*";
			var code:Number = 129;
			//var unicode:String = parseInt( code.toString(), 16 );
			
			trace("CssTokenizerTest::cssTokenizeTest() code: ", code, "'" + String.fromCharCode( code ) + "'" );
			
			var re:RegExp = /[\u000A]/;
			
			var gt:RegExp = new RegExp( "[" + String.fromCharCode( 0x0080 ) + "-" + String.fromCharCode( 0xFFFFF ) + "]" );
			
			trace("CssTokenizerTest::cssTokenizeTest() newline/a:", re.test( "\n" ), re.test( "a" ), gt.test( String.fromCharCode( code ) ) );
		}
	}
}