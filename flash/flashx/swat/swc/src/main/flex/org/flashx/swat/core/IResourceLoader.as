package org.flashx.swat.core {
	
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import org.flashx.core.IDestroy;
	import org.flashx.ioc.IBeanManager;	
	import org.flashx.ui.css.IStyleManager;
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.io.loaders.resources.IResourceList;
	import org.flashx.io.xml.IParser;
		
	import org.flashx.swat.configuration.rsls.IResourceQueueBuilder;	
	
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
				IEventDispatcher,
				IResourceManagerAware {
					
		/**
		* 	A url request to load the configuration document from.
		*/
		function get request():URLRequest;
		function set request( value:URLRequest ):void;
					
		/**
		* 	A parser implementation to use when deserializing
		* 	the configuration xml document.
		*/
		function get parser():IParser;
		function set parser( value:IParser ):void;
					
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