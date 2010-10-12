package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween collection is started.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionStopEvent extends TweenCollectionControlEvent {
		
		public function TweenCollectionStopEvent( tween:ITween )
		{
			super( TweenEvent.COLLECTION_STOP, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionStopEvent( this.tween );
		}
		
	}
	
}