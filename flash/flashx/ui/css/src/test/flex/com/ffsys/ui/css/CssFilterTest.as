package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.filters.*;
	
	/**
	*	Unit tests for css filters.
	*/ 
	public class CssFilterTest
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
		*	Creates a <code>CssFilterTest</code> instance.
		*/ 
		public function CssFilterTest()
		{
			super();
		}
		
		/**
		* 	Tests for verifying filters declared in css files.
		*/
		[Test]
		public function cssFilterTest():void
		{
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			var style:Object = stylesheet.getStyle( "bevel" );
			Assert.assertNotNull( style );
			
			/*
			for( var z:String in style )
			{
				trace(">>>>>>>>>>>>> CssFilterTest::cssFilterTest()", z, style[ z ] );
			}
			
			return;
			*/
			
 			var filter:BevelFilter = BevelFilter( style );
			Assert.assertNotNull( filter );
			Assert.assertEquals( 1, filter.distance );
			Assert.assertEquals( 16711680, filter.highlightColor );
			Assert.assertEquals( 6710886, filter.shadowColor );

			Assert.assertEquals( 0.6, filter.shadowAlpha );
			Assert.assertTrue( filter.knockout );
			Assert.assertEquals( 5, filter.blurX );
			Assert.assertEquals( 10, filter.blurY );
			Assert.assertEquals( 20, filter.strength );
			
			//verify filters are returned as different instances
			var bevel:BevelFilter = BevelFilter( stylesheet.getFilter( "bevel" ) );
			Assert.assertTrue( filter != bevel );
		}
	}
}