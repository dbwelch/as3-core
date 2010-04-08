package com.ffsys.io.loaders.responder {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.ILoadEvent;	
	
	import com.ffsys.io.loaders.responder.ILoadResponder;
	
	/**
	*	Describes the contract for Objects that have decorated
	*	ILoadResponder functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadResponderDecorator
		extends ILoadCumulativeResponder,
		 		ILoadResponderReference,
		 		ILoadResponderListenerHook {
			
		function cleanupResponderListeners( event:ILoadEvent ):void;
		
	}
	
}
