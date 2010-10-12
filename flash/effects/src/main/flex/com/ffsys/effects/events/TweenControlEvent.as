package com.ffsys.effects.events {
	
	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;
	
	/**
	*	Abstract super class for events that are related to the
	*	ITweenStatus interface.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenControlEvent extends TweenEvent {
		
		public function TweenControlEvent( type:String, tween:ITween )
		{
			super( type, tween );
		}
		
		override public function clone():Event
		{
			return new TweenControlEvent( this.type, this.tween );
		}
		
	}
	
}
