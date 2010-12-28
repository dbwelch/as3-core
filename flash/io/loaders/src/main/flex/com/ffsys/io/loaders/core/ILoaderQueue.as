package com.ffsys.io.loaders.core {
	
	import com.ffsys.io.loaders.resources.IResourceAccess;
	
	/**
	*	Describes the contract for instances that queue the loading
	* 	of encapsulated loader elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface ILoaderQueue
		extends ILoaderElement,
				IResourceAccess,
				IPriorityQueue {
					
		/**
		*	Flushes any loaded resources.
		*/
		function flushResources():void;
		
		/**
		* 	Gets an array of all the loaders
		* 	encapsulated by this queue.
		* 
		* 	This includes all loaders that belong to
		* 	descendant queues.
		* 
		* 	@return An array of all the loaders this queue
		* 	encapsulates.
		*/
		function getAllLoaders():Array;
		
		/**
		* 	Gets an array of all the load requests
		* 	encapsulated by this queue.
		* 
		* 	This includes all loaders that belong to
		* 	descendant queues.
		* 
		* 	@return An array of all the load requests this queue
		* 	encapsulates.
		*/
		function getAllRequests():Array;
		
		/**
		* 	Adds a loader or queue to this queue.
		* 
		* 	@param loader The loader element to add.
		* 	@param options Load options to assign when
		* 	a loader is added.
		* 
		* 	@return The added loader element.
		*/
		function addLoader(
			loader:ILoaderElement,
			options:ILoadOptions = null ):ILoaderElement;
			
		/**
		* 	Inserts a loader element at the specified index.
		* 
		* 	This method will return false if the loader parameter
		* 	is null or if the specified index is less than zero.
		* 
		* 	If the specified index exceeds the length of this implementation
		* 	the loader parameter is added to the end.
		* 
		* 	@param loader The loader element to insert.
		* 	@param index The index to insert the loader item into.
		* 
		* 	@return Whether the loader element was inserted.
		*/
		function insertLoaderAt( loader:ILoaderElement, index:int ):Boolean;
		
		/**
		* 	A delay between loading elements.
		*/	
		function set delay( val:int ):void;
		function get delay():int;
		
		/**
		*	Gets the current element that is being loaded.
		*/
		function get item():ILoaderElement;
		
		/**
		*	Gets the index that the queue is currently loading.
		*/
		function get index():int;
		
		/**
		* 	Removes a loader element.
		* 
		* 	@param loader The loader element to remove.
		* 
		* 	@return A boolean indicating whether the element
		* 	was removed.
		*/
		function removeLoader( loader:ILoaderElement ):Boolean;
		
		/**
		* 	Gets a loader element at the specified index.
		* 
		* 	@param index The index to retrieve the element from.
		* 
		* 	@return A loader element or <code>null</code> if one
		* 	could not be found.
		*/
		function getLoaderAt( index:int ):ILoaderElement;
		
		/**
		* 	Gets a loader element by identifier.
		* 
		* 	@param id The identifier of the loader element.
		* 
		* 	@return A loader element or <code>null</code> if one
		* 	could not be found.
		*/
		function getLoaderById( id:String ):ILoaderElement;
		
		/**
		* 	Gets the index of a loader element.
		* 
		* 	@param loader The loader element to retrieve the index of.
		* 
		* 	@return The index of the loader or <code>-1</code> if the loader
		* 	was not found.
		*/
		function getLoaderIndex( loader:ILoaderElement ):int;
		
		/**
		* 	Removes a loader at a specified index.
		* 
		* 	@param index The index to remove the loader at.
		* 
		* 	@return The removed loader element or <code>null</code>.
		*/
		function removeLoaderAt( index:int ):ILoaderElement;
		
		/**
		*	The number of <code>ILoaderElement</code>
		*	instances in this queue.
		*	
		*	@return The length of this queue.
		*/
		function get length():int;
		
		/**
		*	Clears all elements stored by this queue.	
		*/
		function clear():void;
		
		/**
		* 	Determines whether this queue is empty.
		* 
		* 	@return A boolean indicating whether this queue is empty.
		*/
		function isEmpty():Boolean;
		
		/**
		* 	Gets the last loader element contained by this implementation.
		*/
		function last():ILoaderElement;
	
		/**
		* 	Gets the first loader element contained by this implementation.
		*/		
		function first():ILoaderElement;
		
		/**
		* 	Resets this queue so that it is ready to start loading again.
		*/
		function reset():void;
		
		/**
		* 	Flattens this queue to that all nested queues are removed
		* 	and this queue represents <em>all</em> the loaders.
		*/
		function flatten():void;
		
		/**
		* 	Forces all resources to be reloaded even if they have already been
		* 	loaded.
		* 
		* 	@param bytesTotal A known total bytes for all resources to be loaded.
		*/
		function force( bytesTotal:uint = 0 ):void;
		
		/**
		* 	Determines whether this loader queue will reload.
		* 
		* 	@return A boolean indicating whether this queue would reload.
		*/
		function willReload():Boolean;
		
		/**
		* 	Starts reloading the resources encapsulated by this queue.
		*/
		function reload():void;
		
		/**
		*	Appends all the loaders in the source queue
		*	to this queue.
		* 
		* 	This flattens the target queue before appending
		* 	the elements.
		*	
		*	@param source The source loader queue.
		*/
		function append( source:ILoaderQueue ):void;
		
		/**
		*	Adds all the elements from a source loader
		* 	queue to this loader queue.
		*	
		*	@param source The source loader queue.
		*/
		function addElements( source:ILoaderQueue ):void;
	}
}