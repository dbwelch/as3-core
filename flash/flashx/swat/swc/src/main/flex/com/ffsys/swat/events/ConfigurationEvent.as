package com.ffsys.swat.events {
	
	import flash.events.Event;
	
	import com.ffsys.swat.configuration.IConfigurationElement;
	import com.ffsys.swat.core.IConfigurationAware;
	import com.ffsys.swat.core.IResourceLoader;
	
	/**
	*	Encapsulates events dispatched related to the configuration
	* 	data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ConfigurationEvent extends RslEvent
		implements IConfigurationAware {
			
		private var _configuration:IConfigurationElement;
		
		/**
		* 	Events dispatched when the application configuration document has
		* 	been loaded and parsed.
		*/
		public static const CONFIGURATION_LOAD_COMPLETE:String =
			"configurationLoadComplete";
			
		/**
		* 	Events dispatched when the a module configuration document has
		* 	been loaded and parsed.
		*/
		public static const MODULE_CONFIGURATION_LOAD_COMPLETE:String =
			"moduleConfigurationLoadComplete";
		
		/**
		*	Creates a <code>ConfigurationEvent</code> instance.
		*/
		public function ConfigurationEvent(
			type:String,
			preloader:IResourceLoader,
			event:Event = null )
		{
			super( type, preloader, event );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set configuration( configuration:IConfigurationElement ):void
		{
			_configuration = configuration;
		}

		/**
		*	Creates a clone of this event.
		*	
		*	@return The cloned event.	
		*/
		override public function clone():Event
		{
			var event:ConfigurationEvent = new ConfigurationEvent(
				type, preloader, triggerEvent );
			event.configuration = this.configuration;
			return event;
		}
	}
}