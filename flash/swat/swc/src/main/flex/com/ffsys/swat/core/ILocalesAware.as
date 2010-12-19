package com.ffsys.swat.core
{
	import com.ffsys.swat.configuration.locale.ILocaleManager;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the application locales.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface ILocalesAware
	{
		/**
		* 	The application locales.
		*/
		function get locales():ILocaleManager;
		function set locales( value:ILocaleManager ):void;
	}
}