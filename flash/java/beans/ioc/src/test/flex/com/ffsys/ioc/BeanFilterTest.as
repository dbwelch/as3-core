package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.filters.*;
	
	/**
	*	Unit tests for declaring filters in bean files.
	*/ 
	public class BeanFilterTest extends AbstractBeanUnit
	{	
		public var sample:String = 
			(<![CDATA[

			bevel {
				instance-class: class( flash.filters.BevelFilter );
				distance: 1;
				highlight-color: #ff0000;
				shadow-color: #666666;
				shadow-alpha: 0.6;
				knockout: true;
				blur-x: 5;
				blur-y: 10;
				strength: 20;
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>BeanFilterTest</code> instance.
		*/ 
		public function BeanFilterTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying filters declared in bean files.
		*/
		[Test]
		public function beanFilterTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			assertFilterBean( document );
		}
	}
}