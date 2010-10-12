package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween is resumed after being paused.
	*
	*	Note that the start event will fire before this event.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenResumeEvent extends TweenControlEvent {
		
		public function TweenResumeEvent( tween:ITween )
		{
			super( TweenEvent.RESUME, tween );
		}
		
		override public function clone():Event
		{
			return new TweenResumeEvent( this.tween );
		}
		
	}
	
}