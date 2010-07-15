package com.ffsys.io.loaders.responder {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	
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
		extends IEventDispatcher,
				ILoadCompleteResponder {
		
		function resourceNotFoundHandler( event:ResourceNotFoundEvent ):void;
		function resourceLoadStart( event:LoadStartEvent ):void;
		function resourceLoadProgress( event:LoadProgressEvent ):void;
		function resourceLoaded( event:ILoadEvent ):void;
	}
}