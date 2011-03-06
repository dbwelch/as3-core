package com.ffsys.swat.core
{
	/**
	*	Describes the contract for implementations that are aware
	* 	of the global resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IResourcesAware
	{
		/**
		* 	The global application resources.
		*/
		function get resources():IResourceManager;
		function set resources( value:IResourceManager ):void;
	}
}