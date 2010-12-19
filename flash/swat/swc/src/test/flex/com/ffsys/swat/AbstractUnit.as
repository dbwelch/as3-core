package com.ffsys.swat
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import com.ffsys.effects.tween.*;
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.io.loaders.core.*;	
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.Locale;
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.core.*;	
	import com.ffsys.swat.events.*;
	import com.ffsys.swat.view.*;
	
	import com.ffsys.swat.mock.*;
	
	/**
	*	Abstract super class for unit tests.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class AbstractUnit extends Object
	{	
		public static const TIMEOUT:Number = 60000;
		
		public static const TEST_XML_PATH:String =
			"mock-configuration.xml";
		
		private var _bootstrapLoader:BootstrapLoader;
		private var _queue:ILoaderQueue;
		
		/**
		* 	Creates an <code>AbstractUnit</code> instance.
		*/
		public function AbstractUnit()
		{
			super();
		}
		
		/**
		* 	The bootstrap loader.
		*/
		public function get bootstrap():BootstrapLoader
		{
			return _bootstrapLoader;
		}
		
		private function getLinkedClasses():Array
		{
			var output:Array = new Array();
			output.push( MockApplicationController );
			
			output.push( RectangleGraphic );
			output.push( SolidFill );
			output.push( Stroke );	
			
			output.push( Tween );
			output.push( TweenGroup );	
			output.push( TweenSequence );											
			return output;
		}
		
		[Before( async )]
     	public function setUp():void
		{
			var flashvars:DefaultFlashVariables = new DefaultFlashVariables();
			flashvars.configuration = TEST_XML_PATH;
			flashvars.classPathConfiguration = new ClassPathConfiguration();
			var parser:IConfigurationParser = new ConfigurationParser();
			parser.classNodeNameMap.rootInstance =
				new Configuration();
			_bootstrapLoader = new BootstrapLoader(
				parser,
				flashvars );
				
			_bootstrapLoader.view = new DefaultApplicationPreloadView();
			
			_bootstrapLoader.addEventListener(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				Async.asyncHandler( this, assertLoadedConfiguration, TIMEOUT, null, fail ) );			
			
			//_bootstrapLoader.request = new URLRequest( TEST_XML_PATH );
			
			_queue = _bootstrapLoader.load();
			
			_queue.addEventListener(
				LoadEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );			
			
			_queue.addEventListener(
				LoadEvent.LOAD_START,
				loadStart );		
				
			_queue.addEventListener(
				LoadEvent.LOAD_PROGRESS,
				loadProgress );
				
			_queue.addEventListener(
				LoadEvent.DATA,
				loaded );	

			_queue.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBootstrapData, TIMEOUT, null, fail ) );			
		}
		
		[After]
     	public function tearDown():void
		{
			_bootstrapLoader = null;
		}
		
		/**
		*	@private
		*/
		protected function loadStart(
			event:LoadEvent ):void
		{
			//trace("AbstractUnit::loadStart()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loadProgress(
			event:LoadEvent ):void
		{
			//trace("AbstractUnit::loadProgress()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loaded(
			event:LoadEvent ):void
		{
			//trace("AbstractUnit::loaded()", event, event.type, event.uri );
		}		
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:LoadEvent ):void
		{
			//trace("AbstractUnit::resourceNotFound()", event, event.type, event.uri );
		}		
		
		/**
		*	Performs assertions once the configuration data has been
		*	loaded.
		*/
		protected function assertLoadedConfiguration(
			event:ConfigurationEvent,
			passThroughData:Object ):void
		{
			var configuration:IConfiguration = IConfiguration( event.configuration );
			Assert.assertNotNull( configuration );
			var locale:ILocale = Locale.EN_GB;
			configuration.locales.lang = locale.getLanguage();
		}
		
		/**
		*	Performs assertions once the configuration data has been
		*	loaded.
		*/
		protected function assertBootstrapData(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			
		}		
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}