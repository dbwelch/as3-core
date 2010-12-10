package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that contain delta information which is the difference
	*	between the start value and end value for a property
	*	that is being tweened.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenDelta {
		function set deltas( val:Array ):void;
		function get deltas():Array;
	}
}