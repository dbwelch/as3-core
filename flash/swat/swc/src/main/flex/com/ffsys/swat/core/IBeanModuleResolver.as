package com.ffsys.swat.core
{
	/**
	*	Describes the contract for implementations that resolve
	* 	a controller to a bean name that defines a module for
	* 	the controller.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IBeanModuleResolver
	{
		/**
		* 	Attempts to resolve the bean name for a module
		* 	configuration from the class name of a controller.
		* 
		* 	@param controller The controller to extract the bean name from.
		* 
		* 	@return The bean name.
		*/
		function resolve( controller:IApplicationController ):String;
	}
}