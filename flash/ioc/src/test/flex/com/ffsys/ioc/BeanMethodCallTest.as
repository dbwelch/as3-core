package com.ffsys.ioc
{
	import flash.display.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.mock.*;
	
	/**
	*	Unit tests for invoking methods on beans.
	*/ 
	public class BeanMethodCallTest extends AbstractBeanUnit
	{	
		private var _methodInvocation:MockMethodInvocationBean;
		
		public var sample:String = 
			(<![CDATA[
			
			sprite {
				instance-class: class( flash.display.Sprite );
			}

			method-invoker {
				instance-class: class( com.ffsys.ioc.mock.MockMethodInvocationBean );
				nonexistent: call( called );
			}
			
			parameters {
				instance-class: class( com.ffsys.ioc.mock.MockMethodInvocationBean );
				nonexistent: call( called, hello bean world, 16, true, ref( sprite ) );
			}
			
			assign-parameters {
				instance-class: class( com.ffsys.ioc.mock.MockMethodInvocationBean );
				assigned: call( getParameters, hello bean world, 16, true, ref( sprite ) );
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>BeanMethodCallTest</code> instance.
		*/ 
		public function BeanMethodCallTest()
		{
			super();
		}
		
		[Test]
		public function beanMethodCallTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			
			var mock:MockMethodInvocationBean =
				MockMethodInvocationBean( document.getBean( "method-invoker" ) );
			Assert.assertTrue( mock.wasCalled() );
			Assert.assertNotNull( mock.parameters );
			Assert.assertEquals( 0, mock.parameters.length );
		}
		
		[Test]
		public function beanMethodCallParametersTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			
			var mock:MockMethodInvocationBean =
				MockMethodInvocationBean( document.getBean( "parameters" ) );
			Assert.assertTrue( mock.wasCalled() );
			Assert.assertNotNull( mock.parameters );
			Assert.assertEquals( 4, mock.parameters.length );
			Assert.assertEquals( "hello bean world", mock.parameters[ 0 ] );
			Assert.assertEquals( 16, mock.parameters[ 1 ] );
			Assert.assertTrue( mock.parameters[ 2 ] );
			Assert.assertTrue( mock.parameters[ 3 ] is Sprite );
		}
		
		[Test]
		public function beanMethodCallAssignParametersTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			
			var mock:MockMethodInvocationBean =
				MockMethodInvocationBean( document.getBean( "assign-parameters" ) );
			Assert.assertNotNull( mock.assigned );
			Assert.assertEquals( 4, mock.assigned.length );
			Assert.assertEquals( "hello bean world", mock.assigned[ 0 ] );
			Assert.assertEquals( 16, mock.assigned[ 1 ] );
			Assert.assertTrue( mock.assigned[ 2 ] );
			Assert.assertTrue( mock.assigned[ 3 ] is Sprite );
		}				
	}
}