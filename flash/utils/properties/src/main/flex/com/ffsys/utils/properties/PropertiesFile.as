package com.ffsys.utils.properties {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.utils.locale.ILocale;
	
	/**
	*	Handles loading a properties file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class PropertiesFile extends URLLoader {
		
		private var _locale:ILocale;
		private var _properties:IProperties;
		
		/**
		*	Creates a <code>PropertiesFile</code> instance.
		*	
		*	@param locale A locale associated with this set of properties.
		*/
		public function PropertiesFile( locale:ILocale = null )
		{
			super();
			this.locale = locale;
		}
		
		/**
		*	A locale associated with this properties file.	
		*/
		public function get locale():ILocale
		{
			return _locale;
		}
		
		/**
		*	@private	
		*/
		public function set locale( locale:ILocale ):void
		{
			_locale = locale;
		}
		
		/**
		*	The properties loaded by this file.
		*	
		*	This implementation will only be available once the
		*	properties file has completed loading.
		*/
		public function get properties():IProperties
		{
			return _properties;
		}
		
		/**
		*	Loads the property file and parses it into a
		*	properties instance when the file has completed
		*	loading.
		*	
		*	@param request The URL request to load the properties
		*	file from.
		*/
		override public function load( request:URLRequest ):void
		{
			removeLoaderListeners();
			addLoaderListeners();
			super.load( request );
		}
		
		/**
		*	@private	
		*/
		private function addLoaderListeners():void
		{
			addEventListener(
				Event.COMPLETE, completeHandler );
		}
		
		/**
		*	@private	
		*/
		private function removeLoaderListeners():void
		{
			removeEventListener(
				Event.COMPLETE, completeHandler );
		}

		/**
		*	@private	
		*/
		private function completeHandler( event:Event ):void
		{
			removeLoaderListeners();
			_properties = new Properties( this.locale );
			_properties.parse( String( this.data ) );
			dispatchEvent( new PropertiesLoadEvent(
				PropertiesLoadEvent.LOADED, _properties ) );
		}
	}
}