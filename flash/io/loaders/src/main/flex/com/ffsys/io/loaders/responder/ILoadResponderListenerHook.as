package com.ffsys.io.loaders.responder {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Class description.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamspn
	*	@since  26.11.2007
	*/
	public interface ILoadResponderListenerHook {
		/**
		*	Adds the responder listeners to a target ILoadResponder
		*	from a given IEventDispatcher, which currently is the ILoader
		*	instance currently being loaded.
		*
		*	@param dispatcher the IEventDispatcher that will dispatch the load events
		*	@param responder the ILoaderResponder that will respond to the load events
		*	@param filters an Array of String event names to omit from adding as listeners
		*/
		function addResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null,
			filters:Array = null ):void;
			
		/**
		*	Removes all the event listeners from a given IEventDispatcher and ILoadResponder.
		*	
		*	@param dispatcher the IEventDispatcher dispatching the load events
		*	@param responder the ILoadResponder handling the load events
		*/
		function removeResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null ):void;		
	}
	
}
