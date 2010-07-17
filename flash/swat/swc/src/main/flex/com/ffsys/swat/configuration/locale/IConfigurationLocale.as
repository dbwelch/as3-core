package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
	/**
	*	Describes the contract for implementations
	*	that extend the default locale data and encapsulate
	*	additional configurartion information for the locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface IConfigurationLocale extends ILocale {
		
		/**
		*	The collection of message properties files for the locale.
		*/
		function get messages():IRuntimeResourceCollection;
		function set messages( value:IRuntimeResourceCollection ):void;
		
		/**
		*	The collection of error properties files for the locale.
		*/
		function get errors():IRuntimeResourceCollection;
		function set errors( value:IRuntimeResourceCollection ):void;
		
		/**
		*	The path to the fonts file for the locale.
		*/
		function get fonts():IRuntimeResourceCollection;
		function set fonts( value:IRuntimeResourceCollection ):void;
	}
}