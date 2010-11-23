package com.ffsys.swat.core
{
	/**
	* 	Encapsulates constants that represent the binding prefixes
	* 	exposed when parsing xml documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.11.2010
	*/	
	public class Bindings extends Object
	{
		/**
		* 	Binding that exposes the current locale.
		*/
		public static const LOCALE:String = "locale";
	
		/**
		* 	Binding that exposes the current configuration.
		*/
		public static const CONFIGURATION:String = "configuration";
		
		/**
		* 	Binding that exposes the locales for the application.
		*/
		public static const LOCALES:String = "locales";
		
		/**
		* 	Binding that exposes the paths for the application.
		*/
		public static const PATHS:String = "paths";		
	}
}