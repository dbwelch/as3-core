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

		private var _loader:XmlLoader;
		private var _configuration:IConfiguration;
		
		/**
		*	Constructs an <code>ConfigurationLoader</code> instance.
		*/
		public function ConfigurationLoader()
		{
			super();
			_loader = new XmlLoader();
		}
		
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	Gets the loader used to load and parse the XML document.	
		*/
		public function get loader():XmlLoader
		{
			return _loader;
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
			if( _loader )
			{
				_loader.close();
				_loader = null;
			}
			
			_loader = new XmlLoader();
			
			_loader.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_loader.addEventListener(
				LoadStartEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_loader.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_loader.addEventListener(
				LoadEvent.DATA,
				loadComplete, false, 0, false );
			
			_loader.load( request );
		}
		
		/**
		*	@private
		*/
		private function loadStart( event:LoadStartEvent ):void
		{
			// inform the system config loading has begun
			dispatchEvent( event );
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:ResourceNotFoundEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function loadProgress( 
			event:LoadProgressEvent ):void
		{
			//fired while the configuration xml is loading
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function loadComplete( 
			event:XmlLoadEvent ):void
		{
			//configuration xml loaded successfully
			
			_configuration = parse( event.xml );
			
			//cleanup
			_loader.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_loader.removeEventListener(
				LoadStartEvent.LOAD_START, loadStart );
				
			_loader.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS, loadProgress );
			
			_loader.removeEventListener(
				LoadEvent.DATA, loadComplete );
				
			_loader = null;
			
			dispatchEvent( event );
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