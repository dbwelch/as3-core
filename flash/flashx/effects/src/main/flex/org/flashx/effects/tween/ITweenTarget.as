package org.flashx.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that allow access to the underlying target object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenTarget {
		function set target( val:Object ):void;
		function get target():Object;
	}
	
}
