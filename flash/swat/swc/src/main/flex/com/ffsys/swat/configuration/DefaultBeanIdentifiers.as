package com.ffsys.swat.configuration
{
	/**
	*	Encapsulates constants that represent bean identifiers
	* 	exposed to loaded beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class DefaultBeanIdentifiers extends Object
	{
		/**
		* 	The identifier of the flash variables bean.
		*/
		public static const FLASH_VARIABLES:String = "flashvars";
		
		/**
		* 	The identifier of the main application preloader.
		* 
		* 	This instance is at the root of the display list hierarchy
		* 	for the application.
		*/
		public static const MAIN_APPLICATION_VIEW:String = "main-application-view";
		
		/**
		* 	The identifier of the bootstrap preloader.
		*/
		public static const BOOTSTRAP_PRELOADER:String = "bootstrap-preloader";
		
		/**
		* 	The identifier of the preloader view.
		*/
		public static const PRELOADER_VIEW:String = "preloader-view";
		
		/**
		* 	The identifier of the bean that starts the application.
		*/
		public static const APPLICATION_BEAN:String = "application";
		
		/**
		* 	The identifier of the application configuration.
		*/
		public static const CONFIGURATION:String = "configuration";
		
		/**
		* 	The identifier of a module configuration.
		*/
		public static const MODULE_CONFIGURATION:String = "module";
		
		/**
		* 	The identifier of the application meta bean.
		*/
		public static const META:String = "meta";	
		
		/**
		* 	The identifier for resource definitions.
		*/
		public static const RESOURCES:String = "resources";
		
		/**
		* 	The identifier for a single resource definition.
		*/
		public static const RESOURCE:String = "resource";	
		
		/**
		* 	The identifier for a single runtime shared library definition.
		*/
		public static const RSL:String = "rsl";
		
		/**
		* 	The identifier for a collection of runtime shared
		* 	library definitions.
		*/
		public static const RSLS:String = "rsls";
		
		/**
		* 	The identifier of the paths bean.
		*/
		public static const PATHS:String = "paths";
		
		/**
		* 	The identifier of the application locale manager.
		*/
		public static const LOCALES:String = "locales";
		
		/**
		* 	The identifier of the bean that
		* 	represents the currently selected locale.
		*/
		public static const LOCALE:String = "locale";
		
		/**
		* 	The identifier of the locale manager for a module.
		*/
		public static const MODULE_LOCALES:String = "module-locales";
		
		/**
		* 	The identifier of the bean that
		* 	represents the current locale.
		*/
		public static const CURRENT_LOCALE:String = "current-locale";
		
		/**
		* 	The identifier of the bean that
		* 	represents the default locale.
		*/
		public static const DEFAULT_LOCALE:String = "default-locale";
		
		/**
		* 	The application messages.
		*/
		public static const MESSAGES:String = "messages";
		
		/**
		* 	The application error messages.
		*/
		public static const ERRORS:String = "errors";
		
		/**
		* 	The application settings.
		*/
		public static const SETTINGS:String = "settings";
		
		/**
		* 	An identifier for a bean resource collection.
		*/
		public static const BEANS:String = "beans";
		
		/**
		* 	An identifier for a css resource collection.
		*/
		public static const CSS:String = "css";
	
		/**
		* 	An identifier for a fonts resource collection.
		*/
		public static const FONTS:String = "fonts";
		
		/**
		* 	An identifier for a images resource collection.
		*/
		public static const IMAGES:String = "images";

		/**
		* 	An identifier for an xml resource collection.
		*/
		public static const XML_RESOURCES:String = "xml";
		
		/**
		* 	An identifier for an xml beans resource collection.
		*/
		public static const XML_BEANS:String = "xml-beans";

		/**
		* 	An identifier for a text resource collection.
		*/
		public static const TEXT:String = "text";	

		/**
		* 	An identifier for a sounds resource collection.
		*/
		public static const SOUNDS:String = "sounds";
		
		/**
		* 	An identifier for a collection of components.
		*/
		public static const COMPONENTS:String = "components";
		
		/**
		* 	An identifier for a single component.
		*/
		public static const COMPONENT:String = "component";
	}
}