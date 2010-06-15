package com.ffsys.swat.core {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.types.*;
	
	import com.ffsys.swat.configuration.ConfigurationParser;
	import com.ffsys.swat.configuration.ConfigurationLoader;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.Settings;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	import com.ffsys.swat.view.IApplicationPreloadView;
	
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
	public class RuntimeAssetPreloader extends EventDispatcher
		implements IRuntimeAssetPreloader {
		
		public static const CODE_PHASE:String = "code";
		public static const CONFIGURATION_PHASE:String = "configuration";
		public static const FONTS_PHASE:String = "fonts";
		public static const RSLS_PHASE:String = "rsls";
		
		private var _flashvars:IFlashVariables;
		private var _assets:ILoaderQueue;
		private var _configurationLoader:ConfigurationLoader;
		private var _view:IApplicationPreloadView;
		private var _configuration:IConfiguration;
		
		private var _phase:String = CODE_PHASE;
		
		/**
		*	Creates a <code>RuntimeAssetPreloader</code> instance.
		* 
		* 	@param flashvars The flash variables for the application.
		*/
		public function RuntimeAssetPreloader(
			flashvars:IFlashVariables )
		{
			super();
			_flashvars = flashvars;
			_configurationLoader = new ConfigurationLoader();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phase():String
		{
			return _phase;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get view():IApplicationPreloadView
		{
			return _view;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set view( view:IApplicationPreloadView ):void
		{
			_view = view;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	@inheritDoc
		*/
		public function load():void
		{					
			_configurationLoader.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_configurationLoader.addEventListener(
				LoadStartEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_configurationLoader.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_configurationLoader.addEventListener(
				LoadEvent.DATA,
				configurationLoadComplete, false, 0, false );
				
			_configurationLoader.load(
				SwatFlashVariables( _flashvars ).configuration );			
				
			_phase = CONFIGURATION_PHASE;
		}
		
		/**
		*	@private
		*/
		private function configurationLoadComplete( 
			event:XmlLoadEvent ):void
		{			
			//keep a reference to the configuration
			_configuration = _configurationLoader.configuration;
			
			//update the selected locale
			_configuration.lang = SwatFlashVariables( _flashvars ).lang;
			
			_configurationLoader.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_configurationLoader.removeEventListener(
				LoadStartEvent.LOAD_START,
				loadStart );
				
			_configurationLoader.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress );
			
			_configurationLoader.removeEventListener(
				LoadEvent.DATA,
				itemLoaded );

			_configurationLoader.removeEventListener(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE, loadComplete );
				
			this.view.configuration( new RslEvent(
				RslEvent.LOADED,
				this,
				event ) );
				
			var evt:ConfigurationEvent = new ConfigurationEvent(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				this,
				event );
			
			evt.configuration = _configurationLoader.configuration;
			dispatchEvent( evt );
			
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
				loadStart, false, 0, false );
			
			_assets.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_assets.addEventListener(
				LoadEvent.DATA,
				itemLoaded, false, 0, false );
				
			_assets.addEventListener(
				LoadCompleteEvent.LOAD_COMPLETE,
				loadComplete, false, 0, false );
			
			_assets.load();
			
			_phase = RSLS_PHASE;
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:ResourceNotFoundEvent ):void
		{	
			var evt:RslEvent = null;
			
			if( this.view )
			{
				evt = new RslEvent(
					RslEvent.RESOURCE_NOT_FOUND,
					this,
					event );
				
				this.view.resourceNotFound( evt );
			}
		}
		
		/**
		*	@private
		*/
		private function loadStart( event:LoadStartEvent ):void
		{
			var evt:RslEvent = null;
			
			if( this.view )
			{
				evt = new RslEvent(
					RslEvent.LOAD_START,
					this,
					event );
				
				switch( this.phase )
				{
					case CONFIGURATION_PHASE:
						this.view.configuration( evt );
						break;
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
				}
			}
		}
		
		/**
		*	@private
		*/
		private function loadProgress( 
			event:LoadProgressEvent ):void
		{
			var evt:RslEvent = null;
			
			if( this.view )
			{
				evt = new RslEvent(
					RslEvent.LOAD_PROGRESS,
					this,
					event );
				evt.bytesLoaded = event.bytesLoaded;
				evt.bytesTotal = event.bytesTotal;
				
				switch( this.phase )
				{
					case CONFIGURATION_PHASE:
						this.view.configuration( evt );
						break;
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
				}
			}			
		}
		
		/**
		*	@private
		*/
		private function itemLoaded( event:LoadEvent ):void
		{
			var evt:RslEvent = null;
			
			if( this.view )
			{
				evt = new RslEvent(
					RslEvent.LOADED,
					this,
					event );				
				
				switch( this.phase )
				{
					case CONFIGURATION_PHASE:
						this.view.configuration( evt );
						break;
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
				}
			}			
		}
		
		/**
		*	@private
		*/
		private function loadComplete( event:Event ):void
		{
			//cleanup
			_assets.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_assets.removeEventListener(
				LoadStartEvent.LOAD_START,
				loadStart );
			
			_assets.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
					loadProgress );
				
			_assets.removeEventListener(
				LoadEvent.DATA, itemLoaded );
				
			_assets.removeEventListener(
				LoadCompleteEvent.LOAD_COMPLETE, 
				loadComplete );
				
			_assets = null;
			
			//now start the application rendering as we have all the runtime assets
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this,
				event );
				
			_view.complete( evt );
				
			dispatchEvent( evt );
		}
	}
}