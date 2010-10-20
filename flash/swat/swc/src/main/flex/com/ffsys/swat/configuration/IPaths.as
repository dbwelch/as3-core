package com.ffsys.swat.configuration
{
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	import com.ffsys.swat.configuration.rsls.IRuntimeResource;

	/**
	*	Determines the contract for objects that represent
	* 	global path settings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.10.2010
	*/
	public interface IPaths
	{
		/**
		* 	The parent configuration.
		*/
		function get parent():IConfiguration;
		function set parent( parent:IConfiguration ):void;
		
		/**
		* 	A global setting that determines that all runtime
		* 	resources should be loaded using absolute paths.
		*/
		function get absolute():Boolean;
		function set absolute( absolute:Boolean ):void;
		
		/**
		* 	The base path used when creating paths.
		*/
		function get base():String;
		function set base( base:String ):void;
		
		/**
		* 	The prefix used when creating paths.
		*/
		function get prefix():String;
		function set prefix( prefix:String ):void;
		
		/**
		* 	A path to concatenate to the base and prefix
		* 	when loading resources common to all locales.
		*/
		function get common():String;
		function set common( common:String ):void;
		
		/**
		* 	A path to concatenate to the base and prefix
		* 	when loading resources for a specific locale.
		*/
		function get locales():String;
		function set locales( locales:String ):void;
		
		/**
		* 	The full path to the current locale.
		*	
		*	This is null until the configuration has been loaded
		*	at which point this is updated as we know then which
		*	locale the application is running in.
		*/
		function get locale():String;
		function set locale( locale:String ):void;
		
		/**
		*	Gets a clone of this instance with it's paths
		*	modified to include the base and prefix values.
		*	
		*	@return A clone with fully qualified paths.
		*/
		function translate():IPaths;
		
		/**
		* 	Gets the translated path to a resource.
		* 
		* 	@param resource The resource to calculate the path for.
		* 
		* 	@return The translated path.
		*/
		function getTranslatedPath( resource:IRuntimeResource ):String;
		
		/**
		*	Gets the full path to the locale specific directory.
		*	
		*	@param locale The locale to extract the path for.
		*	
		*	@return The full path to the locale.
		*/
		function getLocalePath( locale:IConfigurationLocale ):String;
		
		/**
		*	Creates a clone of this set of paths.
		*/
		function clone():IPaths;		
	}
}