package com.ffsys.utils.properties {
	
	import flash.events.Event;
	import com.ffsys.events.AbstractEvent;
	
	/**
	*	Event dispatched when a properties file has been
	*	loaded and parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class PropertiesLoadEvent extends AbstractEvent {
		
		/**
		*	Event dispatched when a properties file has been loaded
		*	and parsed.	
		*/
		public static const LOADED:String = "propertiesFileLoaded";
		
		/**
		*	@private	
		*/
		private var _properties:IProperties;
		
		/**
		*	Creates a <code>PropertiesLoadEvent</code> instance.
		*	
		*	@param type The event type.
		*	@param properties The parsed properties.
		*/
		public function PropertiesLoadEvent(
			type:String, properties:IProperties )
		{
			super( type );
			_properties = properties;
		}
		
		/**
		*	The properties that have been loaded and parsed.	
		*/
		public function get properties():IProperties
		{
			return _properties;
		}
		
		/**
		*	Creates clone of this event.
		*	
		*	@return The cloned event.	
		*/
		override public function clone():Event
		{
			return new PropertiesLoadEvent( type, properties );
		}
	}
}