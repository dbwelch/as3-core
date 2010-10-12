package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for ITween instances that can cloned.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public interface ITweenClone {
		/**
		*	Creates a new ITween instance that is a complete clone
		*	of this instance.
		*
		*	@return the new ITween instance 
		*/		
		function clone():ITween;
	}
}