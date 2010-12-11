package com.ffsys.io.loaders.resources {
	
	/**
	*	Describes the contract for implementations that provide
	*	access to loaded resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface IResourceAccess {
		
		/**
		* 	Gets a resource by identifier.
		* 
		* 	@param id The identifier for the resource.
		* 	@param list An optional resource list to extract
		* 	the resource from.
		* 	
		* 	@return The resource if it could be located otherwise <code>null</code>.
		*/
		function getResourceById( id:String, list:String = null ):IResource;
		
		/**
		* 	Gets a resource list by identifier.
		* 
		* 	@param id The identifier for the resource list.
		* 
		* 	@return The resource list if it could be located otherwise <code>null</code>.
		*/
		function getResourceListById( id:String ):IResourceList;
		
		/**
		* 	Gets an array of all the resources
		* 	encapsulated by this queue.
		* 
		* 	This includes all resources that belong to
		* 	descendant queues.
		* 
		* 	@return An array of all the load requests this queue
		* 	encapsulates.
		*/
		function getAllResources():Array;
		
		/**
		* 	A list is resources encapsulated by this implementation.
		*/
		function get resources():IResourceList;
	}
}