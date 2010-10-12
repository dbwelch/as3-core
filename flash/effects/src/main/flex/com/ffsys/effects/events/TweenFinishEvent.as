package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween is finished, this
	*	implies a call to finish() has been made on the
	*	ITweenControl instance. 
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenFinishEvent extends TweenEvent {
		
		public function TweenFinishEvent( tween:ITween )
		{
			super( TweenEvent.FINISH, tween );
		}
		
		override public function clone():Event
		{
			return new TweenFinishEvent( this.tween );
		}
		
	}
	
}