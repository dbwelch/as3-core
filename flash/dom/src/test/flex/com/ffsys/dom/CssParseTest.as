package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.css.*;
	
	/**
	*	Unit tests for parsing css documents.
	*/ 
	dynamic public class CssParseTest extends AbstractDomUnit
	{
		/**
		* 	Sample css for this unit test.
		*/
		public var sample:String = <css>
				<![CDATA[
					@unkwown-rule
					@namespace fluid url( http://freeformsystems.com/fluid/css );
					/**/
					/* This is a comment about my lovely style */
					
					{
						unrecognized-property: 100;
						color: #336699;
					}
					
					* {
						color: #ff99ff;
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
					
					/*
					.first{ color: #ff00ff }.another{
						color: #00ff00;
					}
					*/
					
					/* An empty style should still be stored */
					fluid|CheckBox {
						
					}
				]]>
			</css>.toString();
		
		/**
		*	Creates a <code>CssParseTest</code> instance.
		*/ 
		public function CssParseTest()
		{
			super();
		}
		
		[Test]
		public function cssParseTest():void
		{	
			var beans:CssBeanDocument = new CssBeanDocument()
			var doc:CssDocument = CssDocument(
				beans.getBean(
					CssIdentifiers.DOCUMENT ) );
			doc.document = beans;
			doc.parse( sample );
			
			trace("[CSS DOCUMENT XML] CssParseTest::cssParseTest()", doc.xml.toXMLString() );
		}
	}
}