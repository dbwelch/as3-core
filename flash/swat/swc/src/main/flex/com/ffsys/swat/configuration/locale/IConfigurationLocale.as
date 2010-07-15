package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	
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
		*	The path to the messages file for the locale.	
		*/
		function get messages():String;
		function set messages( value:String ):void;
		
		/**
		*	The path to the errors file for the locale.
		*/
		function get errors():String;
		function set errors( value:String ):void;		
		
	}
}