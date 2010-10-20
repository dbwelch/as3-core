package com.ffsys.swat.configuration.rsls
{
	
	/**
	*	Common type for objects that are aware of a resource manager.
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
	public interface IResourceManagerAware
	{

		/**
		*	The resource manager for this instance.
		*/
		function get resources():IResourceManager;
		function set resources( value:IResourceManager ):void;		
	}
}