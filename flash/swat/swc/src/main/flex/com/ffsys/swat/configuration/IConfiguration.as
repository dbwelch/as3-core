package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;	
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.swat.core.IFlashVariablesAware;
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	
	/**
	*	Describes the contract for objects that
	*	encapsulate configuration information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IConfiguration
		extends IFlashVariablesAware {
		
		/**
		* 	Gets the currently selected locale.
		* 
		* 	@return The current locale.
		*/
		function get locale():ILocale;
		
		/**
		*	Gets the language the application should run in.
		*	
		*	@return The language code.
		*/
		function get lang():String;
		
		/**
		*	Sets the language the application should run in.
		*	
		*	@param lang The language code.
		*/
		function set lang( lang:String ):void;		
		
		/**
		*	Gets the locales collection.
		*	
		*	@return The locales collection.	
		*/
		function get locales():ILocaleManager;
		
		/**
		*	Sets the locales collection.
		*	
		*	@param locales The collection of locales.
		*/
		function set locales( locales:ILocaleManager ):void;
		
		/**
		*	Gets the main locale aware string collection.
		*	
		*	@return The main locale aware string collection.
		*/
		function get copy():LocaleAwareStringCollection;
		
		/**
		*	Sets the main locale aware string collection.
		*	
		*	@param locales The main locale aware string collection.
		*/		
		function set copy( copy:LocaleAwareStringCollection ):void;
		
		/**
		*	Gets the application settings.
		*	
		*	@return The application settings.
		*/
		function get settings():Settings;
		
		/**
		*	Sets the application settings.
		*	
		*	@param settings The application settings.
		*/
		function set settings( settings:Settings ):void;		
		
		/**
		*	Gets the lookup table mapping asset identifiers
		*	to class paths.
		*	
		*	@return The asset lookup table.
		*/
		function get assets():StringCollection;

		/**
		*	Gets the lookup table mapping asset identifiers
		*	to class paths.
		*	
		*	@param assets The asset lookup table.
		*/	
		function set assets( assets:StringCollection ):void;
		
		/**
		*	Gets the asset manager for the application.
		*	
		*	@return The asset manager.	
		*/
		function get assetManager():AssetManager;
	
		/**
		*	Sets the asset manager for the application.
		*	
		*	@param assetManager The asset manager.	
		*/
		function set assetManager( assetManager:AssetManager ):void;
		
		/**
		*	Gets the runtime shared library collection. 
		*	
		*	@return The runtime shared library collection
		*/
		function get rsls():RuntimeSharedLibraryCollection;
	
		/**
		*	Sets the runtime shared library collection. 
		*	
		*	@param rsls The runtime shared library collection
		*/
		function set rsls( rsls:RuntimeSharedLibraryCollection ):void;
		
		
		/**
		*	Gets the application defaults.
		*	
		*	@return The application defaults.
		*/
		function get defaults():Defaults;

		/**
		*	Sets the application defaults.
		*	
		*	@param defaults The application defaults.
		*/
		function set defaults( defaults:Defaults ):void;
		
		/**
		*	Gets the application filters.
		*	
		*	@return The application filters.
		*/
		function get filters():IFilterCollection;

		/**
		*	Sets the application filters.
		*	
		*	@param filters The application filters.
		*/
		function set filters( filters:IFilterCollection ):void;		
	}
}