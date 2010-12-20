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
	
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	import com.ffsys.swat.view.IApplicationPreloadView;
	import com.ffsys.swat.view.IApplicationPreloader;

	import com.ffsys.swat.configuration.IConfiguration;
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
		private var _view:IApplicationPreloadView;
		private var _main:IApplicationPreloader;
		
		/**
		*	Creates a <code>BootstrapLoader</code> instance.
		* 
		*	@param parser A parser implementation to use when parsing the
		*	configuration document.
		* 	@param flashvars The flash variables for the application.
		*/
		public function BootstrapLoader(
			parser:IParser,
			flashvars:IFlashVariables )
		{
			_flashvars = flashvars;
			var path:String = DefaultFlashVariables( flashvars ).configuration;
			super( new URLRequest( path ), parser );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get main():IApplicationPreloader
		{
			return _main;
		}

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
		override public function set parser( value:IParser ):void
		{
			super.parser = value;
			
			if( value != null )
			{
				var interpreter:ConfigurationInterpreter = new ConfigurationInterpreter();
				interpreter.flashvars = DefaultFlashVariables( _flashvars );
				value.interpreter = interpreter;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function doWithConfigurationLoader( loader:ParserAwareXmlLoader ):void
		{
			loader.root =
				DefaultFlashVariables( _flashvars ).classPathConfiguration.getConfigurationInstance();
		}		
		
		/**
		*	@private
		*/
		override protected function configurationLoadComplete( 
			event:LoadEvent ):void
		{
			this.configuration = IConfiguration( IResource( event.resource ).data );
			
			//get the resource queue to inject
			this.builder = this.configuration.locales;
			
			super.configurationLoadComplete( event );
			
			//trace("BootstrapLoader::configurationLoadComplete()", this.configuration, this.builder );
			
			var evt:ConfigurationEvent = new ConfigurationEvent(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				this,
				event );
			
			evt.configuration = this.configuration;
			dispatchEvent( evt );
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
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_flashvars = null;
			_view = null;
			_main = null;
		}		
	}
}