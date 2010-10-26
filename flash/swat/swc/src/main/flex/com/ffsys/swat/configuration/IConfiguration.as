package com.ffsys.swat.configuration {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.swat.core.IFlashVariablesAware;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.rsls.ResourceCollection;
	
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
		extends IFlashVariablesAware,
				IMessageAccess,
				IMediaAccess,
				IConfigurationProperties,
				IEventDispatcher {
		
		/**
		*	The locale manager.
		*/
		function get locales():ILocaleManager;
		function set locales( locales:ILocaleManager ):void;
		
		/**
		*	@inheritDoc	
		*/
		function set meta( val:ApplicationMeta ):void;
		function get meta():ApplicationMeta;
		
		/**
		*	The asset manager for the application.
		*/
		function get assetManager():AssetManager;
		function set assetManager( assetManager:AssetManager ):void;
		
		/**
		* 	The path settings used by the application.
		*/
		function get paths():IPaths;
		function set paths( paths:IPaths ):void;
	}
}