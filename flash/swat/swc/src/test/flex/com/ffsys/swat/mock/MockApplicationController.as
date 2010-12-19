package com.ffsys.swat.mock
{
	import com.ffsys.swat.core.*;
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.utils.properties.IProperties;

	public class MockApplicationController extends DefaultApplicationController
		implements 	ILocalesAware,
					IMessagesAware,
					IPathsAware,
					ILocaleAware
	{
		private var _rectangle:RectangleGraphic;
		private var _locales:ILocaleManager;
		private var _locale:IConfigurationLocale;
		private var _messages:IProperties;
		private var _paths:IPaths;
		
		public function MockApplicationController()
		{
			super();
		}
		
		/**
		* 	An example of cross referencing bean documents.
		*/
		public function get rectangle():RectangleGraphic
		{
			return _rectangle;
		}
		
		public function set rectangle( value:RectangleGraphic ):void
		{
			_rectangle = value;
		}
		
		/**
		* 	A reference to the locale manager.
		*/
		public function get locales():ILocaleManager
		{
			return _locales;
		}
		
		public function set locales( value:ILocaleManager ):void
		{
			_locales = value;
		}
		
		/**
		* 	The application messages.
		*/
		public function get messages():IProperties
		{
			return _messages;
		}
		
		public function set messages( value:IProperties ):void
		{
			_messages = value;
		}
		
		/**
		* 	The resource path configuration.
		*/
		public function get paths():IPaths
		{
			return _paths;
		}
		
		public function set paths( value:IPaths ):void
		{
			_paths = value;
		}
		
		/**
		* 	The current locale.
		*/
		public function get locale():IConfigurationLocale
		{
			return _locale;
		}
		
		public function set locale( value:IConfigurationLocale ):void
		{
			_locale = value;
		}
	}
}