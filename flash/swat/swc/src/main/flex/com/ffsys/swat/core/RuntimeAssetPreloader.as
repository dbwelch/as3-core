package com.ffsys.swat.core {

	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.MovieLoadEvent;
	import com.ffsys.io.loaders.types.MovieLoader;
	
	import com.ffsys.swat.configuration.ConfigurationParser;
	import com.ffsys.swat.configuration.ConfigurationLoader;
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
		private var _assets:MovieLoader;
		private var _configurationLoader:ConfigurationLoader;
		
		/**
		*	Creates a <code>RuntimeAssetPreloader</code> instance.
		*/
		public function RuntimeAssetPreloader( flashvars:SwatFlashVariables )
		{
			super();
			
			_flashvars = flashvars;
			
			_configurationLoader = new ConfigurationLoader();
			_configurationLoader.addEventListener(	
				ConfigurationEvent.CONFIGURATION_AVAILABLE, loadComplete );
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

			_configurationLoader.removeEventListener(
				ConfigurationEvent.CONFIGURATION_AVAILABLE, loadComplete );
				
			dispatchEvent( event.clone() );
			
			//now load the assets movie
			loadAssets( new URLRequest(
				event.configuration.settings.getStringById(
					Settings.ASSETS_PATH ) ) );
		}
		
		
		private function loadAssets(
			request:URLRequest = null ):void
		{
			if( _assets )
			{
				_assets.close();
				_assets = null;
			}
			
			_assets = new MovieLoader();
			
			_assets.context =
				new LoaderContext( false, ApplicationDomain.currentDomain );
			
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
				assetsLoadComplete, false, 0, false );
			
			_assets.load( request );
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:ResourceNotFoundEvent ):void
		{
			//fired if the assets movie could not be loaded
		}		
		
		/**
		*	@private
		*/
		private function assetsLoadStart( event:LoadStartEvent ):void
		{
			//
		}		
		
		/**
		*	@private
		*/
		private function assetsLoadProgress( 
			event:LoadProgressEvent ):void
		{
			//
		}
		
		/**
		*	@private
		*/
		private function assetsLoadComplete( 
			event:MovieLoadEvent ):void
		{
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
				LoadEvent.DATA, assetsLoadComplete );
				
			_assets = null;
			
			//now start the application rendering as we have all the runtime assets
			var evt:RslEvent = new RslEvent(
				RslEvent.LIBRARY_LOADED );
			dispatchEvent( evt );
		}
	}
}