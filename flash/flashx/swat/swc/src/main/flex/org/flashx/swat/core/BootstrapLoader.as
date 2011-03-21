package org.flashx.swat.core {

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;	
	
	import org.flashx.core.IFlashVariables;
	
	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.resources.IResource;	
	import org.flashx.io.loaders.types.*;
	
	import org.flashx.io.xml.IParser;
	
	import org.flashx.swat.events.RslEvent;
	import org.flashx.swat.events.ConfigurationEvent;
	
	import org.flashx.swat.view.IApplicationPreloadView;
	import org.flashx.swat.view.IApplicationPreloader;

	import org.flashx.swat.configuration.IConfiguration;
	import org.flashx.swat.configuration.ConfigurationInterpreter;
	
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
		implements 	IBootstrapLoader,
					IFlashVariablesAware {
		
		private var _flashvars:IFlashVariables;
		private var _view:IApplicationPreloadView;
		private var _main:IApplicationPreloader;
		
		/**
		*	Creates a <code>BootstrapLoader</code> instance.
		* 
		*	@param parser A parser implementation to use when parsing the
		*	configuration document.
		*/
		public function BootstrapLoader(
			parser:IParser = null )
		{
			super( null, parser );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}
		
		public function set flashvars( value:IFlashVariables ):void
		{
			_flashvars = value;
			
			//trace("BootstrapLoader::set flashvars()", "SETTING BOOTSTRAP LOADER FLASH VARAIBLES", value );
			
			if( value != null
				&& value is DefaultFlashVariables )
			{
				var path:String = DefaultFlashVariables( value ).configuration;
				this.request = new URLRequest( path );
			}
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
				removeObserver( _view );
				var display:DisplayObject = _view as DisplayObject;
				if( display && display.parent )
				{
					display.parent.removeChild( display );
				}
			}
			
			_view = view;
			
			if( view != null )
			{
				addObserver( view );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set parser( value:IParser ):void
		{
			super.parser = value;
			
			if( value != null
				&& value.interpreter is ConfigurationInterpreter )
			{
				ConfigurationInterpreter( value.interpreter ).flashvars = 
					DefaultFlashVariables( _flashvars );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function doWithConfigurationLoader( loader:ParserAwareXmlLoader ):void
		{
			/*
			loader.root =
				DefaultFlashVariables( _flashvars ).classPathConfiguration.getConfigurationInstance();
			*/
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