package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween stops.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenStopEvent extends TweenControlEvent {
		
		public function TweenStopEvent( tween:ITween )
		{
			super( TweenEvent.STOP, tween );
		}
		
		override public function clone():Event
		{
			return new TweenStopEvent( this.tween );
		}
		
	}
	
}