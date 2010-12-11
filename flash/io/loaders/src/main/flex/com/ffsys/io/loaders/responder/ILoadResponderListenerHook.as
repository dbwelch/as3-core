package com.ffsys.io.loaders.responder {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for implementations that provide
	* 	hooks for adding and removing load event listeners from
	* 	a target load event responder.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamspn
	*	@since  26.11.2007
	*/
	public interface ILoadResponderListenerHook {
		
		/**
		*	Adds load event listeners to a target repsonder.
		*
		*	@param dispatcher The dispatcher that will dispatch the load events.
		*	@param responder The responder that will respond to the load events.
		*	@param filters An array of string event names to omit from adding as listeners.
		*/
		function addResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null,
			filters:Array = null ):void;
			
		/**
		*	Removes load event listeners from a target repsonder.
		*
		*	@param dispatcher The dispatcher that will dispatch the load events.
		*	@param responder The responder that will respond to the load events.
		*/
		function removeResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null ):void;
	}
}