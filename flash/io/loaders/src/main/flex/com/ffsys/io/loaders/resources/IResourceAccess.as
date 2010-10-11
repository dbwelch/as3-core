package com.ffsys.io.loaders.resources {
	
	/**
	*	Describes the contract for instances that provide
	*	an API for accessing loaded remote resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface IResourceAccess {
		function getResourceById( id:String, list:String = null ):IResource;
		function getResourceListById( id:String ):IResourceList;
		function getAllResources():Array;
		function get resources():IResourceList;
	}
}