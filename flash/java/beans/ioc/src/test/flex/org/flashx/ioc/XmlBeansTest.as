package org.flashx.ioc
{
	import flash.utils.getQualifiedClassName;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.ioc.support.xml.*;
	
	import org.flashx.ioc.mock.xml.*;
	
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
					instance-class: class( org.flashx.ioc.mock.xml.MockXmlRootElement );
				}
				
				mock-application-controller {
					instance-class: class( org.flashx.ioc.mock.xml.MockXmlApplicationController );
				}
				
				mock-home-controller {
					instance-class: class( org.flashx.ioc.mock.xml.MockXmlHomeController );
				}				
								
				
			]]>).toString();
			
		public var xml:XML = <mock-root>
			<mock-application-controller>
				<mock-home-controller>
					<property-string>hello bean xml world</property-string>
					<property-true>true</property-true>
					<property-false>false</property-false>
					<property-integer>64</property-integer>					
					<property-float>1.67</property-float>
					<property-null>null</property-null>
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
				
			Assert.assertEquals(
				"hello bean xml world",
				mockRoot.mockApplicationController.mockHomeController.propertyString );
			Assert.assertTrue(
				mockRoot.mockApplicationController.mockHomeController.propertyTrue );
			Assert.assertFalse(
				mockRoot.mockApplicationController.mockHomeController.propertyFalse );				
				
			Assert.assertTrue(
				mockRoot.mockApplicationController.mockHomeController.propertyInteger is Number );
			Assert.assertTrue(
				mockRoot.mockApplicationController.mockHomeController.propertyFloat is Number );				
				
			Assert.assertEquals(
				64,
				mockRoot.mockApplicationController.mockHomeController.propertyInteger );
				
			Assert.assertEquals(
				1.67,
				mockRoot.mockApplicationController.mockHomeController.propertyFloat );			
				
			Assert.assertNull(
				mockRoot.mockApplicationController.mockHomeController.propertyNull );						
		}
	}
}