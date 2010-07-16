package com.ffsys.io.loaders.core {
	
	import flash.net.URLRequest;
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.ISilent;
	import com.ffsys.core.IFatal;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.core.IBytesLoaded;
	
	import com.ffsys.io.loaders.responder.ILoadResponderDecorator;
	import com.ffsys.io.loaders.resources.IResourceAccess;
	
	/**
	*	Describes the contract for instances that contain
	*	queued <code>ILoader</code> implementations.
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
				IEventDispatcher {
					
		/**
		*	Flushes any loaded resources.
		*/
		function flushResources():void;
		
		function getAllLoaders():Array;
		
		function addLoader(
			loader:ILoader,
			options:ILoadOptions = null ):ILoader;
			
		function set delay( val:int ):void;
		function get delay():int;
		
		/**
		*	Gets the current ILoaderElement that is being loaded.
		*/
		
		//--> refactor to 'loader' getter
		function get item():ILoaderElement;
		
		/**
		*	Gets the index that the queue is currently using to
		*	retrieve the ILoaderElement that is loading.
		*/
		function get index():int;
		
		function removeLoader( loader:ILoaderElement ):Boolean;
		function getLoaderAt( index:int ):ILoaderElement;
		function getLoaderById( id:String ):ILoaderElement;
		function getLoaderIndex( loader:ILoaderElement ):int;
		function removeLoaderAt( index:int ):ILoaderElement;
		
		/**
		*	The number of <code>ILoaderElement</code>
		*	instances in this queue.
		*	
		*	@return The length of this queue.
		*/
		function getLength():int;
		
		/**
		*	Clears all ILoader	
		*/
		function clear():void;
		function isEmpty():Boolean;
		
		function addResource( loader:ILoader ):void;
		
		//-->refactor getLastLoader/getFirstLoader
		function last():ILoaderElement;
		function first():ILoaderElement;	
		
		//
		function reset():void;
		function flatten():void;
		
		function force( bytesTotal:uint = 0 ):void;
		function load( bytesTotal:uint = 0 ):void;
		
		function willReload():Boolean;
		function reload():void;
	}
}