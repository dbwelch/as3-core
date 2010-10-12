package com.ffsys.effects.events {
	
	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;
	
	/**
	*	Abstract super class for events that are related
	*	to controlling tween collections.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenCollectionControlEvent extends TweenCollectionEvent {
		
		public function TweenCollectionControlEvent(
			type:String, tween:ITween )
		{
			super( type, tween );
		}
		
		override public function clone():Event
		{
			return new TweenCollectionControlEvent( this.type, this.tween );
		}
		
	}
	
}
