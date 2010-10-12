package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for ITween instances that allow
	*	the tween to be reversed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public interface ITweenReverse {
		
		/**
		*	Reverses a Tween and returns the new underlying Array.
		*
		*	If the target implementing this method is a ITweenCollection
		*	the reversed Array of ITween instances is returned.
		*
		*	If this is called on a Tween instance the startValues and endValues
		*	for the properties being tweened are swapped and an Array of the new
		*	endValues for the Tween is returned.
		*/
		function reverse():Array;
	}
	
}
