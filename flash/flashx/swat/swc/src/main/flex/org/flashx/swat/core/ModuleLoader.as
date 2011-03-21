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

	import org.flashx.swat.configuration.IModuleConfiguration;
	
	/**
	*	Preloads the resources for a module.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.12.2010
	*/
	public class ModuleLoader extends ResourceLoader
		implements IModuleLoader {
		
		/**
		*	Creates a <code>ModuleLoader</code> instance.
		* 
		* 	@param request The url request to load the module configuration from.
		*	@param parser A parser implementation to use when parsing the
		*	module configuration document.
		*/
		public function ModuleLoader(
			request:URLRequest = null,
			parser:IParser = null )
		{
			super( request, parser );
		}	
		
		/**
		*	@private
		*/
		override protected function configurationLoadComplete( 
			event:LoadEvent ):void
		{
			this.configuration = IModuleConfiguration( IResource( event.resource ).data );
			
			//get the resource queue to inject
			this.builder = IModuleConfiguration( this.configuration ).moduleLocales;
			
			super.configurationLoadComplete( event );
			
			//trace("ModuleLoader::configurationLoadComplete()", this.configuration, this.builder );
			
			var evt:ConfigurationEvent = new ConfigurationEvent(
				ConfigurationEvent.MODULE_CONFIGURATION_LOAD_COMPLETE,
				this,
				event );
			
			evt.configuration = this.configuration;
			dispatchEvent( evt );
		}
	}
}