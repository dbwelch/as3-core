package com.ffsys.swat.view {
	
	import flash.filters.BitmapFilter;
	import flash.text.Font;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.text.core.ITextFieldFactory;
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.ISettings;
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	
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
		extends IConfigurationAware {
		
		/**
		* 	The factory class used for creating and working
		* 	with textfields.
		*/
		function get textFieldFactory():ITextFieldFactory;
		
		/**
		* 	Gets the application asset manager.
		* 
		* 	@return The application asset manager.
		*/
		function get assetManager():AssetManager;
		
		/**
		* 	Gets the application settings.
		*
		*	@return The application settings.
		*/
		function get settings():ISettings;
		
		/**
		* 	Gets the application flash variables.
		*	
		*	@return The application flash variables.
		*/
		function get flashvars():IFlashVariables;
		
		/**
		* 	Registers a font from a class path and returns
		* 	an instance of the font.
		* 
		* 	@param classPath The fully qualified class path to the font.
		* 
		* 	@return An instance of the font.
		*/
		function registerFont( classPath:String ):Font;
		
		/**
		* 	Gets the application filters.
		*/
		function get filters():IFilterCollection;
		
		/**
		*	Gets the application copy collection.
		*/
		function get copy():LocaleAwareStringCollection;
		
		/**
		* 	Gets the application assets map between identifiers
		* 	and class paths.
		*/
		function get assets():IStringCollection;
		
		/**
		* 	Gets a copy by identifier selected from the current locale
		* 	copy collection.
		* 
		* 	@param id The identifier for the copy string.
		*/
		function getCopyById( id:String ):String;
	
		/**
		*	Gets a bitmap filter by identifier.
		*/
		function getFilterById( id:String ):BitmapFilter;
	}
}