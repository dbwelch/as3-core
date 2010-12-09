package com.ffsys.ui.css
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ui.graphics.*;
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
		private var _rectangle:RectangleGraphic;
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;
		
		/**
		*	The timeout before the load operation fails.
		*/
		private static const TIMEOUT:Number = 10000;
		
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
				
			queue.addEventListener( LoadEvent.DATA, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_START, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_PROGRESS, loadHandler );
			queue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, loadHandler );
			queue.addEventListener( LoadEvent.LOAD_COMPLETE, loadHandler );
		}
		
		/**
		* 	@private
		*/
		private function loadHandler( event:LoadEvent ):void
		{
			trace("CssUtilsTest::loadHandler(), ", event.type, event.uri );
			if( event.type == LoadEvent.DATA )
			{
				if( event.loader is ImageLoader )
				{
					trace("CssUtilsTest::loadHandler() image available: ",
						ImageResource( event.resource ).bitmapData );
				}else if( event.loader is SoundLoader )
				{
					trace("CssUtilsTest::loadHandler() sound available: ",
					 	SoundResource( event.resource ).sound );
				}else if( event.loader is MovieLoader )
				{
					trace("CssUtilsTest::loadHandler() movie available: ",
					 	MovieResource( event.resource ).loader );
				}
			}else if( event.type == LoadEvent.RESOURCE_NOT_FOUND )
			{
				trace("CssUtilsTest::loadHandler() resource not found: ", event.uri );
			}
		}
		
		[After]
     	public function tearDown():void
		{
			//_styleManager.close = null;
		}
		
		protected function addRequests( manager:IStyleManager ):void
		{
			manager.addStyleSheet( null, new URLRequest( "mock-css.css" ) );
			manager.addStyleSheet( null, new URLRequest( "mock-filters.css" ) );
		}
		
		protected function assertStyleManagerAssets(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			var sheet:ICssStyleSheet = _styleManager.getStyleSheet( "mockCss" );
			var filters:ICssStyleSheet = _styleManager.getStyleSheet( "mockFilters" );
			
			_styleManager.setStyle( "internal-style", { color: 0x336699 } );
			var internalStyle:Object = _styleManager.getStyle( "internal-style" );
			Assert.assertNotNull( internalStyle );
			Assert.assertEquals( 0x336699, internalStyle.color );
			
			trace("CssUtilsTest::assertStyleManagerAssets(), got style sheet: ", sheet, filters );
			
			//test style manager style lookup
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
			
			//test the style sheets retrieved by id
			Assert.assertNotNull( sheet );
			Assert.assertNotNull( filters );
			Assert.assertTrue( sheet is ICssStyleSheet );
			Assert.assertTrue( filters is ICssStyleSheet );
			
			//test the values returned from retrieving the styles from
			//the style manager
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
			Assert.assertTrue( style.propertyBitmap is Bitmap );
			Assert.assertTrue( style.propertySound is Sound );
			Assert.assertTrue( style.propertyMovie is Loader );
			
			//dependencies that cannot be found point to the loader
			//that attempted to load the resource
			var resourceNotFound:Object = style.propertyResourceNotFound;
			Assert.assertTrue( resourceNotFound is ImageLoader );
			//trace("CssUtilsTest::assertStyleManagerAssets() resourceNotFound: ", resourceNotFound );
			
			var filter:BitmapFilter = _styleManager.getFilter( "bevel" );
			Assert.assertTrue( filter is BitmapFilter );
			
			var stylable:CssStyleAware = new CssStyleAware( _styleManager );
			stylable.id = "stylable-identifier";
			stylable.styles = "stylable-test";
			stylable.applyStyles();
			
			Assert.assertEquals( 20, stylable.x );
			Assert.assertEquals( 50, stylable.y );
			Assert.assertEquals( 16738047, stylable.classLevelColor );
			Assert.assertEquals( 16737792, stylable.identifierLevelColor );
			Assert.assertEquals( 3368601, stylable.customColor );
			
			var sprite:Sprite = _styleManager.getStyle( "custom-sprite" ) as Sprite;
			Assert.assertNotNull( sprite );
			Assert.assertEquals( 20, sprite.x );
			Assert.assertEquals( 100, sprite.y );
			Assert.assertFalse( sprite.mouseEnabled );
			
			var rectangle:RectangleGraphic = RectangleGraphic( _styleManager.getStyle( "rectangle" ) );
			var fill:SolidFill = SolidFill( _styleManager.getStyle( "default-fill" ) );
			var stroke:Stroke = Stroke( _styleManager.getStyle( "default-stroke" ) );
			
			Assert.assertNotNull( rectangle );
			Assert.assertNotNull( fill );
			Assert.assertNotNull( stroke );
		}
		
		[Test(async)]
		public function cssLoadParseTest():void
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