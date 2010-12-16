package com.ffsys.swat.core {

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;	
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.types.*;

	import com.ffsys.swat.configuration.ConfigurationLoader;
	import com.ffsys.swat.configuration.IConfigurationParser;
	import com.ffsys.swat.configuration.IConfiguration;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	import com.ffsys.swat.view.IApplicationPreloadView;
	import com.ffsys.swat.view.IApplicationPreloader;
	
	import com.ffsys.swat.configuration.ConfigurationInterpreter;
	
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
		*	Represents the preload phase for message files.
		*/
		public static const MESSAGES_PHASE:String = "messages";
		
		/**
		*	Represents the preload phase for error files.
		*/
		public static const ERRORS_PHASE:String = "errors";
		
		/**
		*	Represents the preload phase for font files.
		*/
		public static const FONTS_PHASE:String = "fonts";
		
		/**
		*	Represents the preload phase for image files.
		*/
		public static const IMAGES_PHASE:String = "images";
		
		/**
		*	Represents the preload phase for sound files.
		*/
		public static const SOUNDS_PHASE:String = "sounds";
		
		/**
		*	Represents the preload phase for runtime shared libraries.	
		*/
		public static const RSLS_PHASE:String = "rsls";
		
		/**
		*	Represents the preload phase for bean documents.	
		*/
		public static const BEANS_PHASE:String = "beans";
		
		/**
		*	Represents the preload phase for XML documents.
		*/
		public static const XML_PHASE:String = "xml";
		
		/**
		*	Represents the preload phase for CSS documents.	
		*/
		public static const CSS_PHASE:String = "css";
		
		private var _flashvars:IFlashVariables;
		private var _assets:ILoaderQueue;
		private var _configurationLoader:ConfigurationLoader;
		private var _view:IApplicationPreloadView;
		private var _configuration:IConfiguration;
		private var _phase:String = CODE_PHASE;
		private var _main:IApplicationPreloader;
		
		private var _phaseIndex:int = -1;
		private var _phases:Array = [
			MESSAGES_PHASE,
			ERRORS_PHASE,
			FONTS_PHASE,
			RSLS_PHASE,
			BEANS_PHASE,
			CSS_PHASE,
			XML_PHASE,
			IMAGES_PHASE,
			SOUNDS_PHASE ];
		
		/**
		*	Creates a <code>RuntimeAssetPreloader</code> instance.
		* 
		* 	@param flashvars The flash variables for the application.
		*	@param parser A parser implementation to use when parsing the
		*	configuration.
		*/
		public function RuntimeAssetPreloader(
			flashvars:IFlashVariables,
			parser:IConfigurationParser )
		{
			super();
			_flashvars = flashvars;
			_configurationLoader = new ConfigurationLoader();
			if( parser != null )
			{
				_configurationLoader.parser = parser;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phases():Array
		{
			return _phases
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
			//should definitely have a parser assigned by now
			var interpreter:ConfigurationInterpreter = new ConfigurationInterpreter();
			interpreter.flashvars = SwatFlashVariables( _flashvars );
			_configurationLoader.parser.interpreter = interpreter;
			
			/*
			trace("RuntimeAssetPreloader::load(), ",
				_configurationLoader.parser, interpreter, _flashvars );
			*/
				
			_configurationLoader.root =
				SwatFlashVariables( _flashvars ).classPathConfiguration.getConfigurationInstance();
					
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
				
			_phase = CONFIGURATION_PHASE;
				
			var path:String = SwatFlashVariables( _flashvars ).configuration;
			_configurationLoader.request = new URLRequest( path );
			_configurationLoader.load();
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
			//_configuration.locales.lang = SwatFlashVariables( _flashvars ).lang;
			
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

			next();
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
					case MESSAGES_PHASE:
						this.view.message( evt );
						break;
					case ERRORS_PHASE:
						this.view.error( evt );
						break;			
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
					case BEANS_PHASE:
						this.view.bean( evt );
						break;				
					case CSS_PHASE:
						this.view.css( evt );
						break;
					case XML_PHASE:
						this.view.xml( evt );
						break;
					case IMAGES_PHASE:
						this.view.image( evt );
						break;
					case SOUNDS_PHASE:
						this.view.sound( evt );
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
					case MESSAGES_PHASE:
						this.view.message( evt );
						break;	
					case ERRORS_PHASE:
						this.view.error( evt );
						break;
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
					case BEANS_PHASE:
						this.view.bean( evt );
						break;						
					case CSS_PHASE:
						this.view.css( evt );
						break;
					case XML_PHASE:
						this.view.xml( evt );
						break;						
					case IMAGES_PHASE:
						this.view.image( evt );
						break;
					case SOUNDS_PHASE:
						this.view.sound( evt );
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
					case MESSAGES_PHASE:
						this.view.message( evt );
						break;
					case ERRORS_PHASE:
						this.view.error( evt );
						break;												
					case FONTS_PHASE:
						this.view.font( evt );
						break;
					case RSLS_PHASE:
						this.view.rsl( evt );
						break;
					case BEANS_PHASE:
						this.view.bean( evt );
						break;						
					case CSS_PHASE:
						this.view.css( evt );
						break;					
					case XML_PHASE:
						this.view.xml( evt );
						break;						
					case IMAGES_PHASE:
						this.view.image( evt );
						break;
					case SOUNDS_PHASE:
						this.view.sound( evt );
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
		*	Moves on to the next load phase.
		*/
		private function next( event:LoadEvent = null ):void
		{
			_phaseIndex++;
			
			removeQueueListeners( next );
			
			//out of index so complete
			if( _phaseIndex >= this.phases.length )
			{
				complete();
				return;
			}
			
			closeAssetsQueue();
			
			var queue:ILoaderQueue = null;
			var phase:String = this.phases[ _phaseIndex ];
			
			//trace("RuntimeAssetPreloader::next(), ", _phaseIndex, phase );
			
			switch( phase )
			{
				case MESSAGES_PHASE:
					queue = this.configuration.locales.getMessagesQueue();
					break;
				case ERRORS_PHASE:
					queue = this.configuration.locales.getErrorsQueue();
					break;
				case FONTS_PHASE:
					queue = this.configuration.locales.getFontsQueue();
					break;
				case RSLS_PHASE:
					queue = this.configuration.locales.getRslsQueue();
					break;
				case BEANS_PHASE:
					queue = this.configuration.locales.getBeansQueue();
					break;
				case CSS_PHASE:
					queue = this.configuration.locales.getCssQueue();
					break;
				case XML_PHASE:
					queue = this.configuration.locales.getXmlQueue();
					break;
				case IMAGES_PHASE:
					queue = this.configuration.locales.getImagesQueue();
					break;
				case SOUNDS_PHASE:
					queue = this.configuration.locales.getSoundsQueue();
					break;
			}
			
			//trace("RuntimeAssetPreloader::next(), ", phase, queue );
			
			if( queue )
			{
				//trace("RuntimeAssetPreloader::next(), ", queue.getLength() );
				
				//empty queue move on to the next phase
				if( queue.isEmpty() )
				{
					next();
					return;
				}
				
				var lastPhase:Boolean = ( _phaseIndex == ( this.phases.length - 1 ) );
				
				_assets = queue;
				addQueueListeners( lastPhase ? loadComplete : next );
				_phase = phase;
				
				if( !_assets.loading )
				{
					_assets.load();
				}
			}
		}
		
		/**
		*	@private
		*/
		private function loadComplete( event:LoadEvent ):void
		{
			complete();
		}	
		
		/**
		*	@private
		*/
		private function complete():void
		{
			//reset the phase index
			_phaseIndex = -1;
			
			//cleanup
			removeQueueListeners();
				
			_assets = null;
			
			//now start the application rendering as we have all the runtime assets
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this );
				
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