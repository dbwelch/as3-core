package com.ffsys.swat.core {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IDestroy;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.swat.configuration.rsls.IResourceQueueBuilder;	
	
	/**
	*	Describes the contract for resource loaders.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IResourceLoader
		extends IDestroy,
				IEventDispatcher {
		
		/**
		* 	A builder responsible for retrieving loader queues
		* 	by load phase.
		* 
		* 	This reference must be set before any attempt is made
		* 	to invoke <code>load</code>.
		*/
		function get builder():IResourceQueueBuilder;
		function set builder( value:IResourceQueueBuilder ):void;
		
		/**
		*	The current preload phase being loaded.
		*/
		function get phase():String;
		
		/**
		*	Starts a load operation.
		* 
		* 	@return The loader queue handling the load process.
		*/
		function load():ILoaderQueue;
	}
}