package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween is complete.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCompleteEvent extends TweenEvent {
		
		public function TweenCompleteEvent( tween:ITween )
		{
			super( TweenEvent.COMPLETE, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCompleteEvent( this.tween );
		}
		
	}
	
}