package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween has ended.
	*
	*	This differs from the complete event in that
	*	if a tween is set to loop the complete event
	*	will only fire when all the loops are complete.
	*
	*	This event fires whenever a Tween reaches it's end
	*	values which means that if a tween is set to loop
	*	once this event will fire twice. Once when it reaches
	*	the end values for the Tween and again when it returns
	*	back to the start values for the Tween.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenEndEvent extends TweenEvent {
		
		public function TweenEndEvent( tween:ITween )
		{
			super( TweenEvent.END, tween );
		}
		
		override public function clone():Event
		{
			return new TweenEndEvent( this.tween );
		}
		
	}
	
}