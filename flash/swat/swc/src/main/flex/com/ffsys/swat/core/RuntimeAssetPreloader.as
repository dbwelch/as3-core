package com.ffsys.swat.core {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.swat.configuration.ConfigurationParser;
	import com.ffsys.swat.configuration.ConfigurationLoader;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.Settings;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	/**
	*	Preloads the application configuration XML document
	* 	and runtime shared libraries.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class RuntimeAssetPreloader extends EventDispatcher {
		
		private var _flashvars:SwatFlashVariables;
		private var _assets:ILoaderQueue;
		private var _configurationLoader:ConfigurationLoader;
		
		private var _configuration:IConfiguration;
		
		/**
		*	Creates a <code>RuntimeAssetPreloader</code> instance.
		* 
		* 	@param flashvars The flash variables for the application.
		*/
		public function RuntimeAssetPreloader(
			flashvars:SwatFlashVariables )
		{
			super();
			
			_flashvars = flashvars;
			
			_configurationLoader = new ConfigurationLoader();
			_configurationLoader.addEventListener(	
				ConfigurationEvent.CONFIGURATION_AVAILABLE, loadComplete );
		}
		
		/**
		* 	Gets the runtime configuration.
		* 
		* 	@return The runtime configuration.
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	Starts the preloading process.	
		*/
		public function load():void
		{	
			_configurationLoader.load(
				_flashvars.configuration );
		}
		
		/**
		*	@private
		*/
		private function loadComplete( 
			event:ConfigurationEvent ):void
		{
			//update the selected locale
			event.configuration.lang = _flashvars.lang;
			
			//keep a reference to the configuration
			_configuration = event.configuration;

			_configurationLoader.removeEventListener(
				ConfigurationEvent.CONFIGURATION_AVAILABLE, loadComplete );
				
			dispatchEvent( event.clone() );
			
			//now load the assets rsls
			loadAssets();
		}
		
		
		private function loadAssets():void
		{
			if( _assets )
			{
				_assets.close();
				_assets = null;
			}
			
			_assets = this.configuration.rsls.queue;
			
			_assets.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
				
			_assets.addEventListener(
				LoadStartEvent.LOAD_START,
				assetsLoadStart, false, 0, false );
			
			_assets.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				assetsLoadProgress, false, 0, false );
			
			_assets.addEventListener(
				LoadEvent.DATA,
				assetLoaded, false, 0, false );
				
			_assets.addEventListener(
				LoadCompleteEvent.LOAD_COMPLETE,
				assetsLoadComplete, false, 0, false );
			
			_assets.load();
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:ResourceNotFoundEvent ):void
		{
			//fired if the assets movie could not be loaded
			
			trace("RuntimeAssetPreloader::resourceNotFound()");
		}
		
		/**
		*	@private
		*/
		private function assetsLoadStart( event:LoadStartEvent ):void
		{
			//
			trace("RuntimeAssetPreloader::assetsLoadStart()");
		}
		
		/**
		*	@private
		*/
		private function assetsLoadProgress( 
			event:LoadProgressEvent ):void
		{
			//
			trace("RuntimeAssetPreloader::assetsLoadProgress()");
		}
		
		/**
		*	@private
		*/
		private function assetLoaded( event:Event ):void
		{
			//
			trace("RuntimeAssetPreloader::assetLoaded()");
		}		
		
		/**
		*	@private
		*/
		private function assetsLoadComplete( event:Event ):void
		{
			
			trace("RuntimeAssetPreloader::assetsLoadComplete()");
			
			//cleanup
			_assets.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_assets.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_assets.removeEventListener(
				LoadStartEvent.LOAD_START,
				assetsLoadStart );
			
			_assets.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS, assetsLoadProgress );
				
			_assets.removeEventListener(
				LoadEvent.DATA, assetLoaded );
				
			_assets.removeEventListener(
				LoadCompleteEvent.LOAD_COMPLETE, assetsLoadComplete );		
				
			_assets = null;
			
			//now start the application rendering as we have all the runtime assets
			var evt:RslEvent = new RslEvent(
				RslEvent.LIBRARY_LOADED );
			dispatchEvent( evt );
		}
	}
}