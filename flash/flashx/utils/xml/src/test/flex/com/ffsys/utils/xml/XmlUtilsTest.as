package com.ffsys.utils.xml {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the xml utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*/
	public class XmlUtilsTest extends Object {
		
		static private const TEST_NODE_NAME:String = "node";
		static private const TEST_NODE_VALUE:String = "a test xml node value";
		static private const TEST_ATTRIBUTE_NAME:String = "testXmlAttribute";
		static private const TEST_NODE_ATTRIBUTES:Object = { testXmlAttribute: "test attribute" };
		
		/**
		* 	Creates an <code>XmlUtilsTest</code> instance.
		*/
		public function XmlUtilsTest()
		{
			super();
		}
		
		[Test]
		public function testGetSimpleXmlNode():void
		{
			var node:XML = XmlUtils.getSimpleXmlNode( 
				TEST_NODE_NAME,
				TEST_NODE_VALUE,
				false,
				TEST_NODE_ATTRIBUTES );
				
			Assert.assertTrue( XmlUtils.isTextNode( node ) );
				
			trace( node.toXMLString() );
			
			Assert.assertEquals( TEST_NODE_NAME, node.name().localName );
			Assert.assertEquals( TEST_NODE_VALUE, node.text()[ 0 ] );
			Assert.assertEquals(
				TEST_NODE_ATTRIBUTES[ TEST_ATTRIBUTE_NAME ],
				node.@[ TEST_ATTRIBUTE_NAME ] );
			
			//now test with the CDATA flag enabled
			node = XmlUtils.getSimpleXmlNode( 
				TEST_NODE_NAME,
				TEST_NODE_VALUE,
				true,
				TEST_NODE_ATTRIBUTES );
				
			Assert.assertTrue( XmlUtils.isTextNode( node ) );				
				
			trace( node.toXMLString() );
			
			Assert.assertEquals( TEST_NODE_NAME, node.name().localName );
			Assert.assertEquals( TEST_NODE_VALUE, node.text()[ 0 ] );
			Assert.assertEquals(
				TEST_NODE_ATTRIBUTES[ TEST_ATTRIBUTE_NAME ],
				node.@[ TEST_ATTRIBUTE_NAME ] );
		}		
		
	}
}