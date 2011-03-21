package org.flashx.swat.configuration.locale {
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.io.xml.IDeserializeProperty;
	import org.flashx.io.xml.IDeserializeComplete;
	
	import org.flashx.utils.locale.ILocale;
	import org.flashx.utils.locale.ILocaleCollection;
	import org.flashx.utils.properties.IProperties;
	
	import org.flashx.swat.configuration.IConfigurationElement;
	import org.flashx.swat.configuration.rsls.IResourceDefinitionManager;
	import org.flashx.swat.configuration.rsls.IResourceDefinitionManagerAware;
	import org.flashx.swat.configuration.rsls.IResourceQueueBuilder;
	import org.flashx.swat.core.IConfigurationAware;
	
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
				IConfigurationAware,
				IResourceDefinitionManagerAware {
		
		/**
		* 	The parent configuration.
		*/
		//function get parent():IConfigurationElement;
		//function set parent( parent:IConfigurationElement ):void;
		
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