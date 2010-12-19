package com.ffsys.swat.configuration.rsls
{
	
	/**
	*	Common type for objects that are aware of a resource definition manager.
	* 
	* 	This allows parent reference within resource managers
	* 	to use the same type allowing the locale manager to have
	* 	a global resource collection and for a resource manager
	* 	to be assigned to a specific locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.10.2010
	*/
	public interface IResourceDefinitionManagerAware
	{
		/**
		*	The resource definition manager for this instance.
		*/
		function get resources():IResourceDefinitionManager;
		function set resources( value:IResourceDefinitionManager ):void;		
	}
}