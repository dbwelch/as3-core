package com.ffsys.swat.core {

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;	
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.IResource;	
	import com.ffsys.io.loaders.types.*;

	import com.ffsys.swat.configuration.IConfigurationParser;
	import com.ffsys.swat.configuration.IConfiguration;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	import com.ffsys.swat.view.IApplicationPreloadView;
	import com.ffsys.swat.view.IApplicationPreloader;
	
	import com.ffsys.swat.configuration.ConfigurationInterpreter;
	
	/**
	*	Preloads the application bootstrap resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class BootstrapLoader extends ResourceLoader
		implements IBootstrapLoader {
		
		private var _flashvars:IFlashVariables;
		private var _configurationLoader:ParserAwareXmlLoader;
		private var _view:IApplicationPreloadView;
		private var _configuration:IConfiguration;
		private var _main:IApplicationPreloader;
		
		/**
		*	Creates a <code>BootstrapLoader</code> instance.
		* 
		* 	@param flashvars The flash variables for the application.
		*	@param parser A parser implementation to use when parsing the
		*	configuration.
		*/
		public function BootstrapLoader(
			flashvars:IFlashVariables,
			parser:IConfigurationParser )
		{
			super();
			_flashvars = flashvars;
			_configurationLoader = new ParserAwareXmlLoader();
			if( parser != null )
			{
				_configurationLoader.parser = parser;
			}
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
		override public function load():ILoaderQueue
		{
			trace("****************************************************** BootstrapLoader::load()", "**************************************************************" );
			
			_assets = new LoaderQueue();
			
			//should definitely have a parser assigned by now
			var interpreter:ConfigurationInterpreter = new ConfigurationInterpreter();
			interpreter.flashvars = DefaultFlashVariables( _flashvars );
			_configurationLoader.parser.interpreter = interpreter;
	
			_configurationLoader.root =
				DefaultFlashVariables( _flashvars ).classPathConfiguration.getConfigurationInstance();
					
			addLoaderListeners( _configurationLoader );
				
			_phase = ResourceLoadPhase.CONFIGURATION_PHASE;
			_assets.customData = _phase;
				
			var path:String = DefaultFlashVariables( _flashvars ).configuration;
			_configurationLoader.request = new URLRequest( path );
			
			_assets.addLoader( _configurationLoader );
			_assets.load();
			return _assets;
		}
		
		protected function addLoaderListeners( loader:IEventDispatcher ):void
		{
			if( loader != null )
			{
				loader.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_START,
					loadStart, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress, false, 0, false );

				loader.addEventListener(
					LoadEvent.DATA,
					configurationLoadComplete, false, 0, false );				
			}
		}
		
		protected function removeLoaderListeners( loader:IEventDispatcher ):void
		{
			if( loader != null )
			{			
				loader.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				loader.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
				
				loader.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
			
				loader.removeEventListener(
					LoadEvent.DATA,
					configurationLoadComplete );				
			}
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_flashvars = null;
			_configurationLoader = null;
			_configuration = null;
			_view = null;
			_main = null;
		}		
		
		/**
		*	@private
		*/
		private function configurationLoadComplete( 
			event:LoadEvent ):void
		{
			removeLoaderListeners( _configurationLoader );
			
			_configuration = IConfiguration( IResource( event.resource ).data );

			var evt:ConfigurationEvent = new ConfigurationEvent(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				this,
				event );
			
			evt.configuration = _configuration;
			dispatchEvent( evt );
			
			//get the resource queue to inject
			this.builder = _configuration.locales;
			var targets:ILoaderQueue = getLoaderQueue( this.builder );
			var queue:ILoaderQueue = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				queue = ILoaderQueue( targets.getLoaderAt( i ) );
				if( !queue.isEmpty() )
				{
					_assets.addLoader( queue );
				}
			}
			
			//update the phase
			if( _assets.length > 1 )
			{
				_phase = String( _assets.getLoaderAt( 1 ).customData );
			}
			
			addQueueListeners( _assets, loadComplete );
			dispatchEvent( event );
		}
		
		
		/**
		*	@private
		*/
		override protected function resourceNotFound(
			event:LoadEvent ):RslEvent
		{	
			var rsl:RslEvent = super.resourceNotFound( event );
			handleViewEvent( rsl );
			return rsl;
		}
		
		/**
		*	@private
		*/
		override protected function loadStart( event:LoadEvent ):RslEvent
		{
			var rsl:RslEvent = super.loadStart( event );	
			handleViewEvent( rsl );			
			return rsl;			
		}
		
		/**
		*	@private
		*/
		override protected function loadProgress( 
			event:LoadEvent ):RslEvent
		{
			var rsl:RslEvent = super.loadProgress( event );
			handleViewEvent( rsl );
			return rsl;			
		}	
		
		/**
		*	@private
		*/
		override protected function itemLoaded( event:LoadEvent ):RslEvent
		{
			var rsl:RslEvent = super.itemLoaded( event );
			handleViewEvent( rsl );	
			return rsl;					
		}	
		
		/**
		* 	@private
		*/
		private function handleViewEvent( event:RslEvent ):void
		{
			if( event != null && this.view )
			{
				view.resource( event );
			}
		}
	}
}