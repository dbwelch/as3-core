package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween collection is paused.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionPauseEvent extends TweenCollectionControlEvent {
		
		public function TweenCollectionPauseEvent( tween:ITween )
		{
			super( TweenEvent.COLLECTION_PAUSE, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionPauseEvent( this.tween );
		}
		
	}
	
}