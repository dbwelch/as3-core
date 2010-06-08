package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;	
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
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
	public interface IConfiguration {
		
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
		function get locales():LocaleCollection;
		
		/**
		*	Sets the locales collection.
		*	
		*	@param locales The collection of locales.
		*/
		function set locales( locales:LocaleCollection ):void;
		
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
	}
}