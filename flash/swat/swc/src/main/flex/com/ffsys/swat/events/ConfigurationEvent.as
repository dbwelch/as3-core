package com.ffsys.swat.events {
	
	import flash.events.Event;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.core.IBootstrapLoader;
	
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
		
		/**
		* 	Events dispatched when the configuration XML has
		* 	been loaded and parsed.
		*/
		public static const CONFIGURATION_LOAD_COMPLETE:String = "configurationLoadComplete";
		
		/**
		*	Creates a <code>ConfigurationEvent</code> instance.
		*/
		public function ConfigurationEvent(
			type:String,
			preloader:IBootstrapLoader,
			event:Event = null )
		{
			super( type, preloader, event );
		}
		
		private var _configuration:IConfiguration;
		
		/**
		*	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
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