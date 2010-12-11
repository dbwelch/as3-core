package com.ffsys.io.loaders.resources {
	
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
	
		function addResource( val:IResourceElement ):int;
		function removeResource( val:IResourceElement ):Boolean;
		function getResourceAt( index:int ):IResourceElement;
		function removeResourceAt( index:int ):IResourceElement;
		function get length():int;
		function last():IResourceElement;
		function first():IResourceElement;
		function clear():void;
		function isEmpty():Boolean;
		
		function getResourcesByType( type:Class ):IResourceList;
		
		function merge(
			source:IResourceList,
			destination:IResourceList = null ):IResourceList;
		
		/**
		*	Returns a new IResourceList containing all the IResource
		*	contained in this list recursively and creates a flat representation
		*	of the IResourceList. In effect, removes any child IResourceList
		*	elements.
		*/
		function flatten():IResourceList;
	}
}