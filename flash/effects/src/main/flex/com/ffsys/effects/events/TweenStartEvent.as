package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween starts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenStartEvent extends TweenControlEvent {
		
		public function TweenStartEvent( tween:ITween )
		{
			super( TweenEvent.START, tween );
		}
		
		override public function clone():Event
		{
			return new TweenStartEvent( this.tween );
		}
		
	}
	
}