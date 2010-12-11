package com.ffsys.io.loaders.responder {
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.responder.ILoadResponder;
	
	/**
	*	Describes the contract for implementations that allow
	* 	load events to be proxied to a load event responder.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadResponderDecorator
		extends ILoadResponder,
		 		ILoadResponderListenerHook {
			
		/**
		* 	Cleans listeners on the responder.
		* 
		* 	@param event The load event that triggered this listener.
		*/
		function cleanupResponderListeners( event:LoadEvent ):void;
		
		/**
		* 	A responder that is receiving the load events.
		*/
		function set responder( val:ILoadResponder ):void;
		function get responder():ILoadResponder;
	}
}