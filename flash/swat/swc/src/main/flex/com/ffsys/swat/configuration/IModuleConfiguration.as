package com.ffsys.swat.configuration
{
	import com.ffsys.swat.core.IConfigurationAware;
	import com.ffsys.swat.configuration.locale.ILocaleManager;	
	
	/**
	*	Describes the contract for module configuration implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IModuleConfiguration 
		extends IConfigurationElement,
				IConfigurationAware
	{
		
		/**
		* 	The locales defined for this module.
		*/
		function get moduleLocales():ILocaleManager;
		function set moduleLocales( value:ILocaleManager ):void;		
	}
}