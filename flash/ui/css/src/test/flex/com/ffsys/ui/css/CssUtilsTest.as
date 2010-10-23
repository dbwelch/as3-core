package com.ffsys.ui.css
{
	import flash.events.Event;
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
		private var _loader:ILoader;
		
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
		
		/**
		*	Gets the loader used for the test.	
		*/
		protected function getLoader():ILoader
		{
			return new TextLoader();
		}
		
		/**
		*	Gets the request used to perform the loading of the asset.
		*/
		protected function getLoadRequest():URLRequest
		{
			return new URLRequest( "mock-css.css" );
		}
		
		[Before( async )]
     	public function setUp():void
		{
			/*
			_loader = getLoader();
			_loader.addEventListener(
				LoadEvent.DATA,
				Async.asyncHandler( this, assertLoadedAsset, TIMEOUT, null, fail ) );
			_loader.load( getLoadRequest() );
			*/
			
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
			_loader = null;
		}
		
		protected function addRequests( manager:IStyleManager ):void
		{
			manager.addStyleSheet( new URLRequest( "mock-css.css" ),
				new CssStyleCollection() );
		}
		
		protected function assertStyleManagerAssets(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			trace("CssUtilsTest::assertStyleManagerAssets(), ", this );
		}
		
		/**
		*	Performs assertions when the asset is loaded.
		*	
		*	@param event The event that loaded the asset.
		*	@param passThroughData The custom pass through data.
		*/
		protected function assertLoadedAsset(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			var text:String = TextResource( event.resource ).text;
			
			var collection:ICssStyleCollection = 
				new CssStyleCollection();
					
			collection.parse( text );
			
			trace("CssUtilsTest::assertLoadedAsset(), ",
				collection.styleNames );
			
			var style:Object = collection.getStyle( "test-style" );
			var ident:Object = collection.getStyle( "#ident" );
			
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
			Assert.assertTrue( style.propertyClass is Class );
			Assert.assertTrue( style.propertyUrl is URLRequest );
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