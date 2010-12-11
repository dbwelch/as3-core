package com.ffsys.io.loaders.core {
	
	import flash.net.URLRequest;
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.ISilent;
	import com.ffsys.core.IFatal;
	import com.ffsys.core.IDestroy;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.core.IBytesLoaded;
	
	import com.ffsys.io.loaders.responder.ILoadResponderDecorator;
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
		 		ILoadResponderDecorator,
				ILoadStatus,
				IForceLoad,
				IBytesTotal,
				IBytesLoaded,
				IResourceAccess,
				IPriorityQueue,
				ISilent,
				IFatal,
				IDestroy,
				IEventDispatcher {
					
		/**
		*	Indicates whether this queue should pause.
		*	
		*	Setting this property does not close any
		*	existing load operation it merely prevents
		*	the queue from proceeding to the next item
		*	until the resume method is called.
		*/
		function get paused():Boolean;
		function set paused( paused:Boolean ):void
		
		/**
		*	Instructs this queue if it is paused to
		*	resume it's load operations from the next
		*	index.
		*/
		function resume():void;
					
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
		* 	@deprecated
		* 
		* 	Adds a resource to this queue.
		* 
		* 	@param loader The loader encapsulating the resource to add.
		*/
		function addResource( loader:ILoader ):void;
		
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
		* 	Start the load process.
		* 
		* 	@param bytesTotal A known total bytes for all resources to be loaded.
		*/
		function load( bytesTotal:uint = 0 ):void;
		
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
		*	@param source The source loader queue.
		*/
		function append( source:ILoaderQueue ):void;
	}
}