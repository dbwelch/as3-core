package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween collection is complete.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionCompleteEvent extends TweenCollectionEvent {
		
		public function TweenCollectionCompleteEvent( tween:ITween )
		{
			super( TweenEvent.COLLECTION_COMPLETE, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionCompleteEvent( this.tween );
		}
		
	}
	
}