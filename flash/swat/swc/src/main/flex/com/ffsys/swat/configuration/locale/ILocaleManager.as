package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.ILocaleCollection;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.xml.IDeserializeProperty;
	import com.ffsys.io.xml.IDeserializeComplete;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationProperties;
	import com.ffsys.swat.configuration.IMessageAccess;
	import com.ffsys.swat.configuration.IMediaAccess;
	
	import com.ffsys.swat.configuration.rsls.IResourceManager;
	import com.ffsys.swat.configuration.rsls.IResourceManagerAware;
	
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
				IMessageAccess,
				IMediaAccess,
		 		IDeserializeProperty,
				IDeserializeComplete,
				IResourceManagerAware {
		
		/**
		* 	The parent configuration.
		*/
		function get parent():IConfiguration;
		function set parent( parent:IConfiguration ):void;
		
		/**
		* 	The currently selected locale.
		*/
		function get current():IConfigurationLocale;
		
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
		
		/**
		*	Gets the loader queue used to load message
		*	properties files for the application.
		*	
		*	@return The message loader queue.
		*/
		function getMessagesQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load error
		*	properties files for the application.
		*	
		*	@return The error loader queue.
		*/
		function getErrorsQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load font
		*	files for the application.
		*	
		*	@return The font loader queue.
		*/
		function getFontsQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load runtime
		*	shared libraries.
		*	
		*	@return The rsl loader queue.
		*/
		function getRslsQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load runtime
		*	CSS files.
		*	
		*	@return The css loader queue.
		*/
		function getCssQueue():ILoaderQueue;		
		
		/**
		*	Gets the loader queue used to load XML documents.
		*	
		*	@return The XML loader queue.
		*/
		function getXmlQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load image
		*	resources.
		*	
		*	@return The image loader queue.
		*/
		function getImagesQueue():ILoaderQueue;
		
		/**
		*	Gets the loader queue used to load sound
		*	resources.
		*	
		*	@return The sound loader queue.
		*/
		function getSoundsQueue():ILoaderQueue;
	}
}