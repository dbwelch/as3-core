package com.ffsys.swat.core {

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.types.*;
	
	import com.ffsys.swat.configuration.ConfigurationParser;
	import com.ffsys.swat.configuration.ConfigurationLoader;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.Settings;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	import com.ffsys.swat.view.IApplicationPreloadView;
	import com.ffsys.swat.view.IApplicationPreloader;
	
	/**
	*	Preloads the application runtime resources.
	*	
	*	By default the runtime preload logic starts by loading the
	*	configuration XML document for the application followed by
	*	the declared messages and error properties files.
	*	
	*	Once the properties files that represent the localized application
	*	text are loaded the application fonts are loaded.
	*	
	*	After the fonts are loaded the runtime shared libraries
	*	are loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class RuntimeAssetPreloader extends EventDispatcher
		implements IRuntimeAssetPreloader {
		
		/**
		*	Represents the preload phase for the main application code.	
		*/
		public static const CODE_PHASE:String = "code";
		
		/**
		*	Represents the preload phase for the configuration XML document.
		*/
		public static const CONFIGURATION_PHASE:String = "configuration";
		
		/**
		*	Represents the preload phase for properties files.
		*/
		public static const PROPERTIES_PHASE:String = "properties";
		
		/**
		*	Represents the preload phase for font files.
		*/
		public static const FONTS_PHASE:String = "fonts";
		
		/**
		*	Represents the preload phase for runtime shared libraries.	
		*/
		public static const RSLS_PHASE:String = "rsls";
		
		private var _flashvars:IFlashVariables;
		private var _assets:ILoaderQueue;
		private var _configurationLoader:ConfigurationLoader;
		private var _view:IApplicationPreloadView;
		private var _configuration:IConfiguration;
		private var _phase:String = CODE_PHASE;
		private var _main:IApplicationPreloader;
		
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
		public function get main():IApplicationPreloader
		{
			return _main;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set main( main:IApplicationPreloader ):void
		{
			_main = main;
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
			if( _view && !view )
			{
				var display:DisplayObject = _view as DisplayObject;
				if( display && display.parent )
				{
					display.parent.removeChild( display );
				}
				
			}
			
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
				LoadEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_configurationLoader.addEventListener(
				LoadEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_configurationLoader.addEventListener(
				LoadEvent.LOAD_PROGRESS,
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
			event:LoadEvent ):void
		{			
			//keep a reference to the configuration
			_configuration = _configurationLoader.configuration;
			
			//update the selected locale
			_configuration.locales.lang = SwatFlashVariables( _flashvars ).lang;
			
			_configurationLoader.removeEventListener(
				LoadEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_configurationLoader.removeEventListener(
				LoadEvent.LOAD_START,
				loadStart );
				
			_configurationLoader.removeEventListener(
				LoadEvent.LOAD_PROGRESS,
				loadProgress );
			
			_configurationLoader.removeEventListener(
				LoadEvent.DATA,
				configurationLoadComplete );
				
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
			
			//load the application messages
			loadMessages();
		}
		
		/**
		*	@private
		*	
		*	Starts loading the message properties files.
		*/
		private function loadMessages():void
		{
			closeAssetsQueue();
			_assets = this.configuration.locales.getMessagesQueue();
			addQueueListeners( messagesLoadComplete );
			_assets.load();
			_phase = PROPERTIES_PHASE;
		}
		
		/**
		*	@private
		*	
		*	Starts loading the error properties files.
		*/
		private function loadErrors():void
		{
			closeAssetsQueue();
			_assets = this.configuration.locales.getErrorsQueue();
			addQueueListeners( errorsLoadComplete );
			_assets.load();
			_phase = PROPERTIES_PHASE;
		}
		
		/**
		*	@private
		*	
		*	Starts loading the font files.
		*/
		private function loadFonts():void
		{
			closeAssetsQueue();
			_assets = this.configuration.locales.getFontsQueue();
			addQueueListeners( fontsLoadComplete );
			_assets.load();
			_phase = FONTS_PHASE;
		}
		
		/**
		*	@private
		*	
		*	Starts loading the runtime shared library assets.	
		*/
		private function loadAssets():void
		{
			closeAssetsQueue();
			_assets = this.configuration.locales.getRslsQueue();
			addQueueListeners();
			_assets.load();
			_phase = RSLS_PHASE;
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:LoadEvent ):void
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
		private function loadStart( event:LoadEvent ):void
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
					case PROPERTIES_PHASE:
						this.view.properties( evt );
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
			event:LoadEvent ):void
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
					case PROPERTIES_PHASE:
						this.view.properties( evt );
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
					case PROPERTIES_PHASE:
						this.view.properties( evt );
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
		private function addQueueListeners( complete:Function = null ):void
		{
			if( complete == null )
			{
				complete = loadComplete;
			}
			
			_assets.addEventListener(
				LoadEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
				
			_assets.addEventListener(
				LoadEvent.LOAD_START,
				loadStart, false, 0, false );
			
			_assets.addEventListener(
				LoadEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_assets.addEventListener(
				LoadEvent.DATA,
				itemLoaded, false, 0, false );
				
			_assets.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				complete, false, 0, false );
		}
		
		/**
		*	@private
		*/
		private function removeQueueListeners( complete:Function = null ):void
		{
			if( complete == null )
			{
				complete = loadComplete;
			}
			
			if( _assets )
			{
				_assets.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				_assets.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				_assets.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
				
				_assets.removeEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				_assets.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					complete );
			}
		}
		
		/**
		*	@private
		*/
		private function messagesLoadComplete( event:LoadEvent ):void
		{
			//cleanup
			removeQueueListeners( messagesLoadComplete );
			_assets = null;
			loadErrors();
		}
		
		/**
		*	@private
		*/
		private function errorsLoadComplete( event:LoadEvent ):void
		{
			//cleanup
			removeQueueListeners( errorsLoadComplete );
			_assets = null;
			loadFonts();
		}
		
		/**
		*	@private
		*/
		private function fontsLoadComplete( event:LoadEvent ):void
		{
			//cleanup
			removeQueueListeners( fontsLoadComplete );
			_assets = null;
			loadAssets();
		}
		
		/**
		*	@private
		*/
		private function loadComplete( event:LoadEvent ):void
		{
			//cleanup
			removeQueueListeners();
				
			_assets = null;
			
			//now start the application rendering as we have all the runtime assets
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this,
				event );
				
			_view.complete( evt );
				
			dispatchEvent( evt );
		}
		
		/**
		*	@private	
		*/
		private function closeAssetsQueue():void
		{
			if( _assets )
			{
				_assets.close();
				_assets = null;
			}			
		}
	}
}