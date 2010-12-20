package com.ffsys.swat.core
{
	import com.ffsys.utils.properties.IProperties;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the application settings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface ISettingsAware
	{
		/**
		* 	The application settings.
		*/
		function get settings():IProperties;
		function set settings( value:IProperties ):void;
	}
}