package org.flashx.io.loaders.resources {
	
	/**
	*	Describes the methods and properties
	*	for instances the maintain a collection
	*	of <code>IResourceList</code> and
	*	<code>IResource</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface IResourceList
		extends IResourceElement,
		 		IResourceAccess {
		
		/**
		* 	Adds a resource to this list.
		* 
		* 	@param resource The resource to add.
		* 
		* 	@return The number of resources in this list.
		*/
		function addResource( resource:IResourceElement ):int;
		
		/**
		* 	Removes a resource from this list.
		* 
		* 	@param resource The resource to remove.
		* 
		* 	@return A boolean indicating whether the resource was removed.
		*/
		function removeResource( resource:IResourceElement ):Boolean;
		
		/**
		* 	Gets a resource at the specified index.
		* 
		* 	@param index The index to retrieve the resource at.
		* 
		* 	@return The resource element at the specified index
		* 	or <code>null</code> if the index is out of bounds.
		*/
		function getResourceAt( index:int ):IResourceElement;
		
		/**
		* 	Removes a resource from this list.
		* 
		* 	@param index The index to retrieve the resource at.
		* 
		* 	@return The removed resource or <code>null</code> if the index
		* 	is out of bounds.
		*/		
		function removeResourceAt( index:int ):IResourceElement;
		
		/**
		* 	Gets the number of resources encapsulated by this list.
		*/
		function get length():int;
		
		/**
		* 	The last resource in this list.
		* 
		* 	@return The last resource in this list or <code>null</code>
		* 	if this list is empty.
		*/
		function last():IResourceElement;
		
		/**
		* 	The first resource in this list.
		* 
		* 	@return The first resource in this list or <code>null</code>
		* 	if this list is empty.
		*/
		function first():IResourceElement;
		
		/**
		* 	Clears all resources stored by this list.
		*/
		function clear():void;
		
		/**
		* 	Determines whethe this list is empty.
		* 
		* 	@return A boolean indicating whether this list is empty.
		*/
		function isEmpty():Boolean;
		
		/**
		* 	Finds resources of the specified type.
		* 
		* 	@param type The type to search for.
		* 
		* 	@return A resource list of the elements found matching
		* 	the specified type.
		*/
		function getResourcesByType( type:Class ):IResourceList;
		
		/**
		* 	Merges the source resource list into the destination
		* 	resource list and returns the merged resource list.
		* 
		* 	If destination is <code>null</code> the destination
		* 	becomes this resource list.
		* 	
		* 	@param source The source resource list.
		* 	@param destination The destination resource list.
		* 
		* 	@return The merged resource list.
		*/
		function merge(
			source:IResourceList,
			destination:IResourceList = null ):IResourceList;
		
		/**
		*	Returns a resource list that contains all
		* 	the elements in this resource list flattened.
		* 
		* 	@return A flattened resource list.
		*/
		function flatten():IResourceList;
	}
}