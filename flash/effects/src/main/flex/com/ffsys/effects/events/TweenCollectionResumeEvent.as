package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;

	/**
	*	Event dispatched when a Tween collection is resumed
	*	after being paused.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionResumeEvent extends TweenCollectionControlEvent {
		
		public function TweenCollectionResumeEvent( tween:ITween )
		{
			super( TweenEvent.COLLECTION_RESUME, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionResumeEvent( this.tween );
		}
		
	}
	
}