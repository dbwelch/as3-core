package com.ffsys.io.loaders.responder {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	
	/**
	*	Describes the contract for Objects that respond to
	*	the load complete event only.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadCompleteResponder {
		function resourceLoadComplete( event:LoadCompleteEvent ):void;
	}
	
}
