package org.w3c.grammar
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.scanner.*;	
	
	/**
	*	Unit tests for tokenizing css documents.
	*/ 
	dynamic public class CssGrammarTest extends Object
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
		
		/*
		
		//Flavours of {bad(uri|commment|string)}
		
		
		/* {badcomment1a} *
		/* a normal comment */
		/* {badcomment2}
		.declaration {}
		/* {badcomment1b} *	
		
		
		#my-bad {
			bad-string: "an incomplete string;
			bad-single-string: 'an incomplete single quote string
		}
		
		#my-bad-uri {
			bad-src: url( http://example.com;
			bad-src-string1: url( "http://example.com";
			bad-src-string2: url( 'http://example.com';
			bad-src-badstring1: url( "http://example.com;
			bad-src-badstring2: url( 'http://example.com;						
		}			
		
		*/
		
		/**
		* 	Sample css for this unit test.
		*/
		public var sample:String = <css>
				<![CDATA[
					@charset "utf-8";
					@charset "UTF-8-duplicate-charset-declaration";
					@import "print.css";
					@import 'print-quotes.css';
					
					@namespace 'http://example.com';
					@namespace "http://example.com";
					@namespace url( 'http://freeformsystems.com/fluid/css' );
					@namespace fluid url( 'http://freeformsystems.com/fluid/css' );
					
					/* @unknown-rule screen, flash-vector; */
					
					/* COMBINATORS */
					parent>child>grandchild>greatgrandchild{};
					h1 child+sibling+brother+sister>child{};
					general~sibling{};
					ancestor descendant{};
					
					fluid|RadioButton {
						/* An inner comment for this empty ruleset */
					}
					
					/* UNIVERSAL ELEMENT TYPE SELECTOR */
					* {
						font-size: 2.5em;
						margin-bottom: 10;
						font-family: 'Arial Narrow', Arial, sans-serif;
					}
					
					/* ATTRIBUTE SELECTORS */
					[href]
					[attr="text"]					
					[attr='text']
					[attr~=includesmatch]
					[attr|=dashmatch]
					[attr^=prefixmatch]
					[attr$='suffixmatch']
					[attr*="substringmatch"]
					
					[lang~=en] {
						color: #ff6600;
					}
				
					/* COMPLEX DOUBLE QUOTED STRING ATTRIBUTE VALUE */
		
					/*
					p[example="public class foo\
					{\
					    private int x;\
					\
					    foo(int x) {\
					        this.x = x;\
					    }\
					\
					}"] { color: red }
					*/
		
					/* COMPLEX SINGLE QUOTED STRING ATTRIBUTE VALUE */					
		
					/*
					p[example='public class foo\
					{\
					    private int x;\
					\
					    foo(int x) {\
					        this.x = x;\
					    }\
					\
					}'] { color: blue }		
					*/					
				
				
				
					
					/*
					@media print {
						h3.big {
							font-size: 2.4em;
						}
					}
					*/
					
					<!-- SOME COMMENT DATA -->
					/**/
					/* a comment with some text */
					
					[media|=flash] {
						-as-custom-style: 0.5 ! important	;
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
					
					/* UNARY OPERATOR */
					.unary {
						negative: -100;
						positive: +100;
					}
					
					/* HEX COLOURS */
					.hex {
						color: #369;
						color: #ff0000;
					}
					
					parent > child{};
					h1 child + sibling{};
					general ~ sibling{};					
					
					/**********
					*
					*	multiline comment.
					*
					**********/
					
					.units {
						size: 10;
						opacity: .5;						
						size: 50.5%;
						size: 99%;
						size: .1%;
						size: 12pt;
						size: 1.2em;
						angle: 45deg;
						margin-left: -.2em;
					}					
					
					simple.selector{};
					h1.red{ color: #ff0000 };
					#id-selector {};
					.class-selector {};
					:link {
						color: #00ff00;
					}
					:custom-pseudo-selector {
						
					}
					
					:pseudo-method();
					
					h1 {
						font-size: 1.2em;
					}
					
					/* RULESET */
					simple.selector, h1.red, #id-selector, .class-selector, :link {
						
					}
				]]>
			</css>.toString();
		
		/**
		*	Creates a <code>CssGrammarTest</code> instance.
		*/ 
		public function CssGrammarTest()
		{
			super();
		}
		
		[Test]
		public function css3GrammarScanTest():void
		{	
			var scanner:Scanner = new Scanner();
			var grammar:CSS3Grammar = new CSS3Grammar();
			grammar.whitespace = false;
			grammar.comments = false;
			scanner.grammar = grammar;
			var results:Vector.<Token> = scanner.scan( sample );
			
			trace("[RESULTS] CssGrammarTest::css3GrammarScanTest()",
				results.length, scanner.source );
			
			if( results.length > 0 )  
			{
				var last:Token = results[ results.length - 1 ];
				trace("CssGrammarTest::css3GrammarScanTest()", last );
			}
		}
	}
}