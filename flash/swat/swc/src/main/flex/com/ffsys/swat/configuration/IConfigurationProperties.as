package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;	
	import com.ffsys.utils.collections.strings.IStringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
	/**
	*	Describes the contract for implementations that
	*	expose access to configuration properties.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public interface IConfigurationProperties {
		
		/**
		*	The main locale aware string collection.
		*/
		function get copy():LocaleAwareStringCollection;
		function set copy( copy:LocaleAwareStringCollection ):void;
		
		/**
		*	The application settings.
		*/
		function get settings():ISettings;
		function set settings( settings:ISettings ):void;
		
		/**
		*	The mapping of asset identifiers to class paths.
		*/
		function get assets():IStringCollection;
		function set assets( assets:IStringCollection ):void;
		
		/**
		*	The runtime shared library collection. 
		*/
		function get rsls():IRuntimeResourceCollection;
		function set rsls( rsls:IRuntimeResourceCollection ):void;
		
		/**
		*	The application defaults.
		*/
		function get defaults():IDefaults;
		function set defaults( defaults:IDefaults ):void;
		
		/**
		*	The application filters.
		*/
		function get filters():IFilterCollection;
		function set filters( filters:IFilterCollection ):void;
	}
}