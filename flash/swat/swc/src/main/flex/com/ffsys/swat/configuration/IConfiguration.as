package com.ffsys.swat.configuration {
	
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	
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
		extends IConfigurationElement {
		
		/**
		*	The locale manager.
		*/
		function get locales():ILocaleManager;
		function set locales( locales:ILocaleManager ):void;
		
		/**
		*	Application meta data.
		*/
		function set meta( val:ApplicationMeta ):void;
		function get meta():ApplicationMeta;
	}
}