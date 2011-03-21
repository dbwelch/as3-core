package org.flashx.effects.tween {

	import flash.events.IEventDispatcher;
	
	/**
	*	Decribes the contract for instances that hook in to
	*	ITween events and dispatch them on.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public interface ITweenEventProxy extends IEventDispatcher {
		
		function addProxyListeners( dispatcher:IEventDispatcher ):void;
		function removeProxyListeners( dispatcher:IEventDispatcher ):void;
		
		function dispatchStartEvent( event:TweenEvent ):void;
		function dispatchStopEvent( event:TweenEvent ):void;
		function dispatchPauseEvent( event:TweenEvent ):void;
		function dispatchResumeEvent( event:TweenEvent ):void;
		function dispatchUpdateEvent( event:TweenEvent ):void;
		function dispatchEndEvent( event:TweenEvent ):void;
		function dispatchCompleteEvent( event:TweenEvent ):void;
	}
	
}
