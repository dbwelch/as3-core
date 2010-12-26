package com.ffsys.swat.core {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.ioc.IBeanManager;	
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.resources.IResourceList;
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
		* 	Adds an observer to this resource loader.
		* 
		* 	@param observer The observer implementation.
		* 
		* 	@return A boolean indicating whether the observer
		* 	was added.
		*/
		function addObserver( observer:IResourceLoadObserver ):Boolean;
		
		/**
		* 	Removes an observer from this resource loader.
		* 
		* 	@param observer The observer implementation.
		* 
		* 	@return A boolean indicating whether the observer
		* 	was removed.
		*/
		function removeObserver( observer:IResourceLoadObserver ):Boolean;
					
		/**
		* 	The bean manager used to load bean resources.
		*/
		function get beanManager():IBeanManager;
		function set beanManager( value:IBeanManager ):void;
		
		/**
		* 	The style manager used to load style resources.
		*/
		function get styleManager():IStyleManager;
		function set styleManager( value:IStyleManager ):void;
		
		/**
		* 	The resource manager managing
		* 	access to the loaded resources.
		*/
		function get resources():IResourceManager;
		
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