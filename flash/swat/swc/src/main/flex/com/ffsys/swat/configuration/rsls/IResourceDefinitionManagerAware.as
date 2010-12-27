package com.ffsys.swat.configuration.rsls
{
	
	/**
	*	Common type for objects that are aware of a resource definition manager.
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