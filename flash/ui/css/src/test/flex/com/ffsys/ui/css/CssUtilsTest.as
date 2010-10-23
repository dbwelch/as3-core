package com.ffsys.ui.css
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.filters.BitmapFilter;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	import com.ffsys.io.loaders.resources.*;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Unit tests for <code>CssUtilsTest</code>.
	*/ 
	public class CssUtilsTest
	{
		
		/**
		*	The timeout before the load operation fails.
		*/
		private static const TIMEOUT:Number = 5000;
		
		/**
		*	@private	
		*/
		private var _styleManager:IStyleManager;
		
		/**
		*	Creates a <code>CssUtilsTest</code> instance.
		*/ 
		public function CssUtilsTest()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_styleManager = new StyleManager();
			addRequests( _styleManager );
			var queue:ILoaderQueue = _styleManager.load();
			queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertStyleManagerAssets, TIMEOUT, null, fail ) );
		}
		
		[After]
     	public function tearDown():void
		{
			//_styleManager.close = null;
		}
		
		protected function addRequests( manager:IStyleManager ):void
		{
			manager.addStyleSheet( new URLRequest( "mock-css.css" ),
				new CssStyleCollection() );
			manager.addStyleSheet( new URLRequest( "mock-filters.css" ),
				new CssStyleCollection() );
		}
		
		protected function assertStyleManagerAssets(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			trace("CssUtilsTest::assertStyleManagerAssets(), ", this );
			
			var style:Object = _styleManager.getStyle( "test-style" );
			var ident:Object = _styleManager.getStyle( "#ident" );
			
			
			trace("CssUtilsTest::assertStyleManagerAssets(), ",
				_styleManager.styleNames, style, ident );
			
			for( var z:String in style )
			{
				trace( "Style: "
					+ z + " || " + style[ z ],
					getQualifiedClassName( style[ z ] ) );
			}
			
			Assert.assertEquals( "a test string", style.propertyString );
			Assert.assertEquals( 10, style.propertyNumber );
			Assert.assertEquals( 1.67, style.propertyFloat );
			Assert.assertTrue( style.propertyTrue );
			Assert.assertFalse( style.propertyFalse );
			Assert.assertNull( style.propertyNull );
			Assert.assertTrue( style.propertyUndefined == undefined );
			Assert.assertTrue( isNaN( style.propertyNan ) );
			Assert.assertTrue( style.propertyArray is Array );
			Assert.assertEquals( 4, style.propertyArray.length );
			Assert.assertEquals( "apples", style.propertyArray[ 0 ] );
			Assert.assertEquals( 10, style.propertyArray[ 1 ] );
			Assert.assertEquals( 3.14, style.propertyArray[ 2 ] );
			Assert.assertEquals( true, style.propertyArray[ 3 ] );
			Assert.assertTrue( style.propertyClass is Class );
			Assert.assertTrue( style.propertyUrl is URLRequest );
			Assert.assertTrue( style.propertyBitmap is BitmapData );
			Assert.assertTrue( style.propertySound is Sound );
			Assert.assertTrue( style.propertyMovie is Loader );
		}
		
		[Test(async)]
		public function cssParseTest():void
		{
			//start the load process
		}		
		
		/**
		*	@private	
		*/
		private function fail( event:Event ):void
		{
			throw new Error( "A loader test case timed out." );
		}		
	}
}