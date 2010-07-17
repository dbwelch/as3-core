package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.ILocaleCollection;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.xml.IDeserializeProperty;
	
	import com.ffsys.swat.configuration.IConfigurationProperties;
	
	/**
	*	Describes the contract for implementations
	*	that manage the available locales for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface ILocaleManager
		extends ILocaleCollection,
				IConfigurationProperties,
				IResourceCollectionAware,
		 		IDeserializeProperty {
		
		/**
		* 	The currently selected locale.
		*/
		function get current():IConfigurationLocale;
		
		/**
		*	The language the application should run in.
		*/
		function get lang():String;
		function set lang( lang:String ):void;
		
		/**
		*	Gets the loader queue used to load properties
		*	files for the application.
		*	
		*	@return The properties loader queue.
		*/
		function getPropertiesQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load font
		*	files for the application.
		*	
		*	@return The fonts loader queue.
		*/
		function getFontsQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load runtime
		*	shared libraries.
		*	
		*	@return The rsl loader queue.
		*/
		function getRslQueue():ILoaderQueue;
	}
}