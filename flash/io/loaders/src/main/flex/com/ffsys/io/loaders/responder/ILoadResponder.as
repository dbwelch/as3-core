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
		
		function resourceLoadStart( event:LoadEvent ):void;
		function resourceLoadProgress( event:LoadEvent ):void;
		function resourceLoaded( event:LoadEvent ):void;
		function resourceLoadComplete( event:LoadEvent ):void;
		function resourceNotFoundHandler( event:LoadEvent ):void;		
	}
}