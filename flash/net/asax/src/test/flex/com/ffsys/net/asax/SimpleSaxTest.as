package com.ffsys.net.asax
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for parsing simple primitive documents
	* 	using a SAX parser.
	*/ 
	public class SimpleSaxTest extends Object
	{
		
		/**
		*	Creates a <code>SimpleSaxTest</code> instance.
		*/ 
		public function SimpleSaxTest()
		{
			super();				
		}
		
		public function get sample():XML
		{
			return <object
				abc="123"
				id="root"
				xmlns="http://example.com/sample"
				xmlns:ui="http://example.com/nested-sample">
				text
	            <!-- comment -->
	            <?instruction ?>
				<string>
					this is a <em>test</em> string
				</string>
				<booleanTrue>true</booleanTrue>
				<booleanFalse>false</booleanFalse>
				<nullValue>null</nullValue>
				<integerValue>10</integerValue>
				<floatValue>1.67</floatValue>
				<hyphen-test>100</hyphen-test>
				<nested id="my-identifier">
					<child><![CDATA[This is some character data]]></child>
					<ui:button />
				</nested>
				<nested-sibling />
			</object>;
		}
		
		[Test]
		public function saxParserText():void
		{
			var parser:SaxParser = new SaxObjectParser();
			//var handler:SaxHandler = new SaxHandler();
			//parser.handlers.push( handler );
			parser.parse( sample );
		}
	}
}