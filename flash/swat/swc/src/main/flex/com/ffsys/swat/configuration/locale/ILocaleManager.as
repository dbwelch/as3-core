package com.ffsys.swat.configuration.locale {
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.xml.IDeserializeProperty;
	import com.ffsys.io.xml.IDeserializeComplete;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.ILocaleCollection;
	import com.ffsys.utils.properties.IProperties;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.rsls.IResourceDefinitionManager;
	import com.ffsys.swat.configuration.rsls.IResourceDefinitionManagerAware;
	import com.ffsys.swat.configuration.rsls.IResourceQueueBuilder;
	
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
		 		IDeserializeProperty,
				IDeserializeComplete,
				IResourceQueueBuilder,
				IResourceDefinitionManagerAware {
		
		/**
		* 	The parent configuration.
		*/
		function get parent():IConfiguration;
		function set parent( parent:IConfiguration ):void;
		
		/**
		* 	The currently selected locale.
		*/
		function get current():IConfigurationLocale;
		function set current( value:IConfigurationLocale ):void;
		
		/**
		*	A default locale to use when extracting
		*	message and error strings.
		*/		
		function get defaultLocale():IConfigurationLocale;
		function set defaultLocale( value:IConfigurationLocale ):void;
		
		/**
		*	The language the application should run in.
		*/
		function get lang():String;
		function set lang( lang:String ):void;
	}
}