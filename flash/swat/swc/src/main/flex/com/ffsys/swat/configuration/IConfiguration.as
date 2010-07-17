package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.swat.core.IFlashVariablesAware;
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.rsls.RuntimeResourceCollection;
	
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
				IConfigurationProperties {
		
		/**
		*	The locale manager.
		*/
		function get locales():ILocaleManager;
		function set locales( locales:ILocaleManager ):void;
		
		/**
		*	The asset manager for the application.
		*/
		function get assetManager():AssetManager;
		function set assetManager( assetManager:AssetManager ):void;		
	}
}