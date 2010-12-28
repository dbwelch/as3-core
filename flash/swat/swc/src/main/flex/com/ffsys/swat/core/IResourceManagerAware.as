package com.ffsys.swat.core
{
	
	public interface IResourceManagerAware
	{	
		/**
		* 	The resource manager managing
		* 	access to the loaded resources.
		*/
		function get resources():IResourceManager;
		function set resources( resources:IResourceManager ):void;	
	}

}

