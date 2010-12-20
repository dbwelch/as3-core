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
		* 	The identifier of the bean that starts the application.
		*/
		public static const APPLICATION_BEAN:String = "application";
		
		/**
		* 	The identifier of the injected configuration bean.
		*/
		public static const CONFIGURATION:String = "configuration";
		
		/**
		* 	The identifier of the injected flash variables bean.
		*/
		public static const FLASH_VARIABLES:String = "flashvars";
		
		/**
		* 	The identifier of the injected paths bean.
		*/
		public static const PATHS:String = "paths";
		
		/**
		* 	The identifier of the injected locales bean.
		*/
		public static const LOCALES:String = "locales";
		
		/**
		* 	The identifier of the injected bean that
		* 	represents the currently selected locale.
		*/
		public static const LOCALE:String = "locale";
		
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
		* 	The identifier of the injected bean that
		* 	represents loaded global resources.
		*/
		public static const RESOURCES:String = "resources";
		
		/**
		* 	The identifier of the injected main application preloader.
		* 
		* 	This instance is at the root of the display list hierarchy
		* 	for the application.
		*/
		public static const MAIN_APPLICATION_VIEW:String = "main-application-view";
		
		/**
		* 	The identifier of the injected bootstrap preloader.
		*/
		public static const BOOTSTRAP_PRELOADER:String = "bootstrap-preloader";
		
		/**
		* 	The identifier of the injected preloader view.
		*/
		public static const PRELOADER_VIEW:String = "preloader-view";
	}
}