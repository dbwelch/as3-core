package com.ffsys.swat.core
{
	import com.ffsys.io.loaders.resources.IResourceList;
	
	/**
	*	Describes the contract for resource manager implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IResourceManager
	{
		/**
		* 	The main resource list being managed.
		*/
		function get list():IResourceList;
		function set list( value:IResourceList ):void;
	}
}