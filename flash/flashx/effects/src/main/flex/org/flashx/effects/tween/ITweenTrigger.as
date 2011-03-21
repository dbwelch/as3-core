package org.flashx.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that can trigger (start) when a given Event
	*	occurs on another ITween instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenTrigger {
		
		function set trigger( trigger:ITween ):void;
		function get trigger():ITween;
		
		function hasTrigger():Boolean;
		function removeTrigger():void;
	}
	
}
