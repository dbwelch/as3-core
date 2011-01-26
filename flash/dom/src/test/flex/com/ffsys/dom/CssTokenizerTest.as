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
			//u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})? - unicode range
			
			//{ causta: "}" + ({7} * '\'') }
			
			var tokenizer:CssTokenizer = new CssTokenizer();
			var results:Vector.<Token> = tokenizer.parse( sample );
			
			trace("[RESULTS] CssTokenizerTest::cssTokenizeTest()", results.length );
			
			var tkn:Token = null;
			for each( tkn in results )
			{
				//trace("CssTokenizerTest::cssTokenizeTest()", tkn.id, tkn.matched );
				
				trace( tkn );
			}
			
			trace("CssTokenizerTest::cssTokenizeTest()", /^(u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?)/.test( "u+0080-ffff" ) );
		}
	}
}