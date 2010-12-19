package com.ffsys.swat.core
{
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the current locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface ILocaleAware
	{
		/**
		* 	The current locale.
		*/
		function get locale():IConfigurationLocale;
		function set locale( value:IConfigurationLocale ):void;
	}
}