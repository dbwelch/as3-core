package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween is paused.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenPauseEvent extends TweenControlEvent {
		
		public function TweenPauseEvent( tween:ITween )
		{
			super( TweenEvent.PAUSE, tween );
		}
		
		override public function clone():Event
		{
			return new TweenPauseEvent( this.tween );
		}
		
	}
	
}