/**
*	Classes used for event response handling.
*/
package com.ffsys.io.loaders.responder {
	
	import flash.events.IEventDispatcher;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	/**
	*	Describes the contract for Objects that respond
	*	to all core ILoader events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadResponder
		extends IEventDispatcher {
		
		/**
		* 	Invoked when a resource starts loading.
		* 
		* 	@param event The event that triggered this listener.
		*/
		function resourceLoadStart( event:LoadEvent ):void;
		
		/**
		* 	Invoked while a resource is loading.
		* 
		* 	@param event The event that triggered this listener.
		*/
		function resourceLoadProgress( event:LoadEvent ):void;
		
		/**
		* 	Invoked when a resource is loaded.
		* 
		* 	@param event The event that triggered this listener.
		*/
		function resourceLoaded( event:LoadEvent ):void;
		
		/**
		* 	Invoked when a resource has completed loaded.
		* 
		* 	@param event The event that triggered this listener.
		*/
		function resourceLoadComplete( event:LoadEvent ):void;
		
		/**
		* 	Invoked when a resource could not be found.
		* 
		* 	@param event The event that triggered this listener.
		*/
		function resourceNotFoundHandler( event:LoadEvent ):void;		
	}
}