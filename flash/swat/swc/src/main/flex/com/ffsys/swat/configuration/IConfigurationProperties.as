package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.rsls.IResourceCollection;
	
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
		*	The application settings.
		*/
		function get settings():ISettings;
		function set settings( settings:ISettings ):void;
		
		/**
		*	The mapping of asset identifiers to class paths.
		*/
		function get assets():IStringCollection;
		function set assets( assets:IStringCollection ):void;
	}
}