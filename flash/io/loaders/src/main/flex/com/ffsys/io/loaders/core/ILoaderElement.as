package com.ffsys.io.loaders.core {
	
	import flash.events.IEventDispatcher;

	import com.ffsys.core.IDestroy;	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.io.connection.IConnection;
	
	import com.ffsys.io.loaders.resources.IResourceElement;	
	
	/**
	*	Common type for instances that can
	*	exist in <code>ILoaderQueue</code> implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface ILoaderElement
		extends IConnection,
				IStringIdentifier,				
				IDestroy,
				IEventDispatcher {	
					

		/**
		* 	The load options for this element.
		*/
		function get options():ILoadOptions;
		function set options( value:ILoadOptions ):void;	
					
		/**
		* 	Determines whether a resource should be reloaded
		* 	even if it has already been loaded.
		*/		
		function set forceLoad( val:Boolean ):void;
		function get forceLoad():Boolean;
					
		/**
		*	An resource associated with this implementation.
		* 
		* 	For loader implementations this is a resource whilst
		* 	for loader queue implementations this will be a resource
		* 	list.
		*/
		function set resource( val:IResourceElement ):void;
		function get resource():IResourceElement;	
					
		
		/**
		*	Arbitrary custom data associated with
		*	this loader element.
		*/
		function set customData( val:Object ):void;
		function get customData():Object;					
				
		/**
		*	A queue that owns this element.
		* 
		* 	This property will only exist if this
		* 	element has been added to a queue.
		*/		
		function set queue( queue:ILoaderQueue ):void;
		function get queue():ILoaderQueue;
		
		/**
		* 	The total number of bytes.
		*/		
		function get bytesTotal():uint;
		
		/**
		* 	The total number of bytes this element has loaded
		* 	since the last time the load method was invoked.
		*/
		function get bytesLoaded():uint;
		
		/**
		*	Indicates whether this element should pause.
		*	
		*	Setting this property on a loader queue does not close any
		*	existing load operation it merely prevents
		*	the queue from proceeding to the next item
		*	until the resume method is called.
		*/
		function get paused():Boolean;
		function set paused( paused:Boolean ):void;	
		
		/**
		*	Resumes a paused load operation.
		*/
		function resume():void;
		
		/**
		*	Indicates whether a load operation is currently
		*	in progress.
		*/
		function get loading():Boolean;

		/**
		*	Indicates that a resource was successfully
		*	loaded and an underlying <code>IResource</code>
		*	is available for the <code>ILoaderElement</code>
		*	instance.
		*/
		function get loaded():Boolean;

		/**
		*	Indicates whether a load operation is complete,
		*	this will be true even if the resource was not loaded
		*	successfully for example if an IO error or resource
		*	not found was encountered.
		*/
		function get complete():Boolean;
		
		/**
		*	Starts the load operation on this load element.
		*/
		function load():void;
	}
}