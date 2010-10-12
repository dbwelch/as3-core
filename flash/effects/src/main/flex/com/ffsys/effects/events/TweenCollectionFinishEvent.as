package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when an ITweenCollection is finished,
	*	this implies a call to finish() has been made on the
	*	ITweenControl instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionFinishEvent extends TweenCollectionEvent {
		
		public function TweenCollectionFinishEvent( tween:ITween )
		{
			super( TweenEvent.COLLECTION_FINISH, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionFinishEvent( this.tween );
		}
		
	}
	
}