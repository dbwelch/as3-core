package com.ffsys.effects.tween {

	import flash.events.IEventDispatcher;
	
	import com.ffsys.effects.events.TweenCompleteEvent;
	import com.ffsys.effects.events.TweenEndEvent;
	import com.ffsys.effects.events.TweenPauseEvent;
	import com.ffsys.effects.events.TweenResumeEvent;
	import com.ffsys.effects.events.TweenStartEvent;
	import com.ffsys.effects.events.TweenStopEvent;
	import com.ffsys.effects.events.TweenUpdateEvent;
	
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
		
		function dispatchStartEvent( event:TweenStartEvent ):void;
		function dispatchStopEvent( event:TweenStopEvent ):void;
		function dispatchPauseEvent( event:TweenPauseEvent ):void;
		function dispatchResumeEvent( event:TweenResumeEvent ):void;
		function dispatchUpdateEvent( event:TweenUpdateEvent ):void;
		function dispatchEndEvent( event:TweenEndEvent ):void;
		function dispatchCompleteEvent( event:TweenCompleteEvent ):void;
	}
	
}
