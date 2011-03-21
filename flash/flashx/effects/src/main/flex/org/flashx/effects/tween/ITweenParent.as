package org.flashx.effects.tween {
	
	/*
	*	Describes the contract for ITween instances that
	*	have a reference to their parent.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.08.2007
	*/
	public interface ITweenParent {
		
		/**
		* 	A parent tween implementation that owns this tween.
		*/
		function get parent():ITween;
		function set parent( val:ITween ):void;
	}
}