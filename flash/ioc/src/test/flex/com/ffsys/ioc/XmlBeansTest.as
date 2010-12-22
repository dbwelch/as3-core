package com.ffsys.ioc
{
	import flash.utils.getQualifiedClassName;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.support.xml.*;
	
	import com.ffsys.ioc.mock.xml.*;
	
	/**
	*	Unit tests for associating beans with xml elements.
	*/ 
	public class XmlBeansTest extends AbstractBeanUnit
	{	
		private var _linkedClasses:Array =[
			MockXmlRootElement,
			MockXmlApplicationController,
			MockXmlHomeController
		];
		
		public var sample:String = 
			(<![CDATA[
				
				mock-root {
					instance-class: class( com.ffsys.ioc.mock.xml.MockXmlRootElement );
				}
				
				mock-application-controller {
					instance-class: class( com.ffsys.ioc.mock.xml.MockXmlApplicationController );
				}
				
				mock-home-controller {
					instance-class: class( com.ffsys.ioc.mock.xml.MockXmlHomeController );
				}				
								
				
			]]>).toString();
			
		public var xml:XML = <mock-root>
			<mock-application-controller>
				<mock-home-controller>
					
				</mock-home-controller>
			</mock-application-controller>
		</mock-root>;
		
		/**
		*	Creates a <code>XmlBeansTest</code> instance.
		*/ 
		public function XmlBeansTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying xml bean mappings.
		*/
		[Test]
		public function xmlBeanTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			
			//check the bean xml objects are valid
			var xmlParser:BeanXmlParser = new BeanXmlParser( document );
			Assert.assertNotNull( xmlParser.document );
			Assert.assertTrue( xmlParser.interpreter is BeanXmlInterpreter );
			Assert.assertNotNull( BeanXmlInterpreter( xmlParser.interpreter ).document );
			
			//check the deserialized data is valid
			var root:Object = xmlParser.deserialize( xml );
			Assert.assertTrue( root is MockXmlRootElement );
			var mockRoot:MockXmlRootElement = MockXmlRootElement( root );
			Assert.assertTrue(
				mockRoot.mockApplicationController is MockXmlApplicationController );
			Assert.assertTrue(
				mockRoot.mockApplicationController.mockHomeController is MockXmlHomeController );
		}
	}
}