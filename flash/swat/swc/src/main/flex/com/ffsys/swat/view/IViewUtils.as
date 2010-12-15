package com.ffsys.swat.view {
	
	import flash.filters.BitmapFilter;
	import flash.text.Font;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.ISettings;
	import com.ffsys.swat.configuration.IMessageAccess;
	import com.ffsys.swat.configuration.IMediaAccess;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	*	Describes the contract for an instance
	*	that exposes utility classes and encapsulates
	*	access to various configuration collections.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface IViewUtils
		extends IConfigurationAware,
				IBeanAccess,
		 		IMessageAccess,
		 		IMediaAccess {
			
		/**
		* 	Gets a path relative to a locale.
		* 
		* 	If no locale is specified this method will use
		* 	the current locale for the application.
		* 
		* 	@param path The relative portion of the path.
		* 	@param locale The locale used to retrieve the base path.
		* 
		* 	@return The full path for the locale specific resource.
		*/
		function getLocalePath( path:String, locale:IConfigurationLocale = null ):String;
		
		/**
		* 	Gets the application flash variables.
		*	
		*	@return The application flash variables.
		*/
		function get flashvars():IFlashVariables;
		
		/* DEPRECATED */
		
		/**
		* 	@deprecated
		* 
		* 	Gets the application settings.
		*
		*	@return The application settings.
		*/
		function get settings():ISettings;
		
		/**
		* 	@deprecated
		* 	
		* 	Gets the application asset manager.
		* 
		* 	@return The application asset manager.
		*/
		function get assetManager():AssetManager;
		
		/**
		*	@deprecated
		*	
		*	Deprecated, use the font loading mechanism instead.
		*	
		* 	Registers a font from a class path and returns
		* 	an instance of the font.
		* 
		* 	@param classPath The fully qualified class path to the font.
		* 
		* 	@return An instance of the font.
		*/
		function registerFont( classPath:String ):Font;
		
		/**
		* 	@deprecated
		* 
		* 	Gets the application assets map between identifiers
		* 	and class paths.
		* 
		* 	This has been replaced by enhaced css functionality.
		*/
		function get assets():IStringCollection;
	}
}