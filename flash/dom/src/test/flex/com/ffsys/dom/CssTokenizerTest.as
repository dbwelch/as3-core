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
					@charset "utf-8";
					
					#id
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
		}
	}
}