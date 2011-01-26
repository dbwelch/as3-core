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
			
		}
	}
}