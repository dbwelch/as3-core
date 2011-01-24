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
					.special {
						font-size: 2em;
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
			var parser:CssParser = new CssParser();
			
			parser.parse( sample );
		}
	}
}