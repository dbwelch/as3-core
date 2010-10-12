package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when the properties of the target Object
	*	being tweened are updated.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenUpdateEvent extends TweenEvent {
		
		public function TweenUpdateEvent( tween:ITween )
		{
			super( TweenEvent.UPDATE, tween );
		}
		
		override public function clone():Event
		{
			return new TweenUpdateEvent( this.tween );
		}
		
	}
	
}