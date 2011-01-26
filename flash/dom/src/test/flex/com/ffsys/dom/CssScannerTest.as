package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.css.*;
	import com.ffsys.scanner.*;
	
	/**
	*	Unit tests for tokenizing css documents.
	*/ 
	dynamic public class CssScannerTest extends AbstractDomUnit
	{
		/*
		
		@unkwown-rule
		@namespace fluid url( http://freeformsystems.com/fluid/css );
		@media print {
			h2.big {
				font-size: 2.4em;
			}
		}
		
		{
			unrecognized-property: 100;
			color: #336699;
		}

		quoted {
			font-family: "Arial Narrow", Arial, sans-serif;
		}

		* {
			color: #ff99ff;
		}

		p {
			font-size: 72px;
		}

		p.inch {
			font-size: 1in;
		}

		p.cm {
			font-size: 2.54cm;
		}

		p.mm {
			font-size: 25.4mm;
		}

		p.pt {
			font-size: 72pt;
		}

		p.pc {
			font-size: 6pc;
		}

		h1, h2, h3, h4, h5, h6 {
			font-size: 1.2em;
		}

		.special {
			font-size: 2em;
			font-family : Arial, Helvetica, sans-serif;
		}

		.condensed{color:#ff6600;background-color:#0066ff}

		#id {
			color: #ff6600;
		}

		.inline { color: #00ff00 }
		
		fluid|CheckBox {

		}
		
		*/
		
		/**
		* 	Sample css for this unit test.
		*/
		public var sample:String = <css>
				<![CDATA[
					@charset "utf-8";
					@import "print.css";
					
					@media print {
						h3.big {
							font-size: 2.4em;
						}
					}
					
					<!-- SOME COMMENT DATA -->
					/**/
					/* a comment with some text */
					
					@namespace fluid url( 'http://freeformsystems.com/fluid/css' );
					
					fluid|RadioButton {
						/* An inner comment for this empty ruleset */
					}
					
					[media|=flash] {
						-as-custom-style: 0.5 ! important	;
					}
					
					[lang~=en] {
						color: #ff6600;
					}
					
					[attr~=includesmatch]
					
					[attr|=dashmatch]
					
					[attr^=prefixmatch]
					
					[attr$=suffixmatch]
					
					[attr*=substringmatch]
					
					p[example="public class foo\
					{\
					    private int x;\
					\
					    foo(int x) {\
					        this.x = x;\
					    }\
					\
					}"] { color: red }
					
					p[example='public class foo\
					{\
					    private int x;\
					\
					    foo(int x) {\
					        this.x = x;\
					    }\
					\
					}'] { color: blue }
					
					* {
						font-size: 2.5em;
						margin-bottom: 10;
						font-family: 'Arial Narrow', Arial, sans-serif;
					}
					
					#id {
						width: 100%;
						unicode-range: u+0080-ffff;
						method: func( x + 1 );
						background-image: url( assets/images/background.jpg );
						background-image-absolute: url( http://freeformsystems.com/assets/images/background.jpg );
						quoted-url: url( "http://freeformsystems.com/" );
						single-quoted-url: url( 'http://freeformsystems.com/' );
					}
					
					#my-bad {
						bad-string: "an incomplete string;
						bad-single-string: 'an incomplete single quote string
					}
					
					/* Flavours of {baduri} */
					#my-bad-uri {
						bad-src: url( http://example.com;
						bad-src-string1: url( "http://example.com";
						bad-src-string2: url( 'http://example.com';
						bad-src-badstring1: url( "http://example.com;
						bad-src-badstring2: url( 'http://example.com;						
					}
					
					.num {
						size: 10;
						opacity: .5;						
						size: 50.5%;
						size: 99%;
						size: .1%;
						size: 12pt;
						size: 1.2em;
						margin-left: -.2em;
					}
					
					/**********
					*
					*	multiline comment.
					*
					**********/
					
					/* {badcomment1a} *
					/* a normal comment */
					/* {badcomment2}
					.declaration {}
					/* {badcomment1b} *
					.after { color: red; }	
					
					.unary {
						negative: -100;
						positive: +100;
					}			
				]]>
			</css>.toString();
		
		/**
		*	Creates a <code>CssScannerTest</code> instance.
		*/ 
		public function CssScannerTest()
		{
			super();
		}
		
		[Test]
		public function cssTokenizeTest():void
		{	
			//u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})? - unicode range
			
			//{ causta: "}" + ({7} * '\'') }
			
			var scanner:CssScanner = new CssScanner();
			var results:Vector.<Token> = scanner.scan( sample );
			
			trace("[RESULTS] CssScannerTest::cssTokenizeTest()", results.length );
			
			var tkn:Token = null;
			for each( tkn in results )
			{
				//trace("CssScannerTest::cssTokenizeTest()", tkn.id, tkn.matched );
				
				trace( tkn );
			}
			
			trace("CssScannerTest::cssTokenizeTest()", /^(u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?)/.test( "u+0080-ffff" ) );
			
			trace( /[\u000A]/.test( "\n" ), /[\u000A-\u000B]/.test( String.fromCharCode( 11 ) ) );
		}
	}
}