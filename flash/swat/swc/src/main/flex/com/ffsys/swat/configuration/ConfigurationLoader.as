package com.ffsys.swat.configuration {

	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.XmlLoadEvent;
	import com.ffsys.io.loaders.types.XmlLoader;
	
	import com.ffsys.swat.events.ConfigurationEvent;
	
	/**
	*	Preloads the application configuration XML document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.05.2010
	*/
	public class ConfigurationLoader extends EventDispatcher {

		private var _configuration:XmlLoader;
		
		/**
		*	Constructs an <code>ConfigurationLoader</code> instance.
		*/
		public function ConfigurationLoader()
		{
			super();
			_configuration = new XmlLoader();
		}
		
		/**
		*	Starts the configuration loading process.
		* 
		* 	@param path The path to load.
		*/
		public function load( path:String ):void
		{
			loadConfiguration( new URLRequest( path ) );
		}
		
		/**
		*	@private
		*	
		*	Loads the configuration xml document.
		*/
		private function loadConfiguration(
			request:URLRequest = null ):void
		{
			if( _configuration )
			{
				_configuration.close();
				_configuration = null;
			}
			
			_configuration = new XmlLoader();
			
			_configuration.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_configuration.addEventListener(
				LoadStartEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_configuration.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_configuration.addEventListener(
				LoadEvent.DATA,
				loadComplete, false, 0, false );
			
			_configuration.load( request );
		}
		
		/**
		*	@private
		*/
		private function loadStart( event:LoadStartEvent ):void
		{
			// inform the system config loading has begun
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:ResourceNotFoundEvent ):void
		{
			//fired if the configuration xml could not be loaded
			
			throw new Error( "The requested document could not be loaded." );
		}
		
		/**
		*	@private
		*/
		private function loadProgress( 
			event:LoadProgressEvent ):void
		{
			//fired while the configuration xml is loading
		}
		
		/**
		*	@private
		*/
		private function loadComplete( 
			event:XmlLoadEvent ):void
		{
			//configuration xml loaded successfully
			
			var configuration:IConfiguration = parse( event.xml );
			
			//cleanup
			_configuration.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_configuration.removeEventListener(
				LoadStartEvent.LOAD_START, loadStart );
				
			_configuration.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS, loadProgress );
			
			_configuration.removeEventListener(
				LoadEvent.DATA, loadComplete );
				
			_configuration = null;
			
			var evt:ConfigurationEvent = new ConfigurationEvent(
				ConfigurationEvent.CONFIGURATION_AVAILABLE );
			evt.configuration = configuration;
			dispatchEvent( evt );
		}
		
		/**
		*	@private
		*	
		*	Parses the xml definition document to
		*	an instance.
		*/
		private function parse( x:XML ):IConfiguration
		{
			var parser:ConfigurationParser =
				new ConfigurationParser();
			var configuration:IConfiguration = new Configuration();
			configuration = parser.parse( x , configuration );
			return configuration;
		}
	}
}