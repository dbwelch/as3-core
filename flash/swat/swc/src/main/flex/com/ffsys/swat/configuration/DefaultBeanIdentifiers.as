package com.ffsys.swat.configuration
{
	
	/**
	*	Encapsulates constants that represent bean identifiers.
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
	}
}