package com.ffsys.swat.core
{
	import com.ffsys.swat.configuration.IConfigurationElement;
	
	/**
	*	Describes the contract for instances that are aware
	* 	of the application configuration data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IConfigurationAware
	{	
		/**
		* 	Gets the application configuration data.
		* 
		* 	@return The configuration data.
		*/
		function get configuration():IConfigurationElement;
		
		/**
		* 	Sets the application configuration data.
		* 
		* 	@param configuration The configuration data.
		*/
		function set configuration( configuration:IConfigurationElement ):void;
	}
}