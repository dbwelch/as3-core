package org.flashx.swat.mock
{
	import org.flashx.swat.core.*;
	import org.flashx.swat.configuration.*;
	import org.flashx.swat.configuration.locale.*;
	import org.flashx.swat.view.*;
	import org.flashx.ui.graphics.*;
	
	import org.flashx.utils.properties.IProperties;
	import org.flashx.utils.properties.IMessagesAware;	

	public class MockApplicationController extends DefaultController
		implements 	IApplicationMainController,
					ILocalesAware,
					IMessagesAware,
					IErrorMessagesAware,
					IPathsAware,
					ILocaleAware,
					ISettingsAware,
					IResourcesAware
	{
		private var _rectangle:RectangleGraphic;
		private var _locales:ILocaleManager;
		private var _locale:IConfigurationLocale;
		private var _messages:IProperties;
		private var _errors:IProperties;
		private var _settings:IProperties;
		private var _paths:IPaths;
		private var _resources:IResourceManager;
		
		public function MockApplicationController()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function ready(
			parent:IApplication,
			main:IApplicationPreloader,
			runtime:IBootstrapLoader,
			view:IApplicationPreloadView ):Boolean
		{
			//
			return true;
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
		* 	The application error messages.
		*/
		public function get errors():IProperties
		{
			return _errors;
		}

		public function set errors( value:IProperties ):void
		{
			_errors = value;
		}	
		
		/**
		* 	The application settings.
		*/
		public function get settings():IProperties
		{
			return _settings;
		}

		public function set settings( value:IProperties ):void
		{
			_settings = value;
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
		
		/**
		* 	The global application resources.
		*/
		public function get resources():IResourceManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceManager ):void
		{
			_resources = value;
		}
	}
}