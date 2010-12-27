package com.ffsys.swat
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import com.ffsys.ioc.*;
	import com.ffsys.ioc.support.xml.*;

	import com.ffsys.effects.tween.*;
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.io.loaders.core.*;	
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.xml.*;	
	
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
		
		/**
		* 	@private
		*/
		protected var _queue:ILoaderQueue;
		
		/**
		* 	@private
		*/
		protected var _framework:IBeanDocument;
		
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
			output.push( MockFileLoaderBean );
			
			output.push( RectangleGraphic );
			output.push( SolidFill );
			output.push( Stroke );	
			
			output.push( Tween );
			output.push( TweenGroup );	
			output.push( TweenSequence );											
			return output;
		}
		
		public function get framework():IBeanDocument
		{
			return _framework;
		}
		
		[Before( async )]
     	public function setUp():void
		{
			var flashvars:DefaultFlashVariables = new DefaultFlashVariables();
			flashvars.configuration = TEST_XML_PATH;
			
			var document:IBeanDocument = BeanDocumentFactory.create();
			_framework = BeanDocumentFactory.create();
			
			var beanConfiguration:IBeanConfiguration = new ApplicationBeanConfiguration();
			beanConfiguration.doWithBeans( _framework );
			
			var parser:IParser = new ConfigurationParser( _framework );
			
			//trace("AbstractUnit::setUp()", parser, parser.interpreter );
			
			_bootstrapLoader = new BootstrapLoader(
				parser,
				flashvars );
				
			//var configuration:BeanConfiguration = new BeanConfiguration();
			//configuration.doWithBeans( document );			
				
			_bootstrapLoader.view = new DefaultApplicationPreloadView( false );
			
			_bootstrapLoader.addEventListener(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				Async.asyncHandler( this, assertLoadedConfiguration, TIMEOUT, null, fail ) );
			
			_bootstrapLoader.addEventListener(
				RslEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );	
			
			_bootstrapLoader.addEventListener(
				RslEvent.LOAD_START,
				loadStart );		
				
			_bootstrapLoader.addEventListener(
				RslEvent.LOAD_PROGRESS,
				loadProgress );
				
			_bootstrapLoader.addEventListener(
				RslEvent.LOADED,
				loaded );	

			_bootstrapLoader.addEventListener(
				RslEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertBootstrapData, TIMEOUT, null, fail ) );
				
			_queue = _bootstrapLoader.load();					
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
			event:RslEvent ):void
		{
			//trace("AbstractUnit::loadStart()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loadProgress(
			event:RslEvent ):void
		{
			//trace("AbstractUnit::loadProgress()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loaded(
			event:RslEvent ):void
		{
			//trace("AbstractUnit::loaded()", event, event.type, event.uri );
		}		
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:RslEvent ):void
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
			event:RslEvent,
			passThroughData:Object ):void
		{
			
		}		
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}