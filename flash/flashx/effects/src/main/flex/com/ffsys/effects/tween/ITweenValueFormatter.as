package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for Objects that can
	*	modify the value of a property while a tween is
	*	in progress. This is useful if you need to format
	*	the value, for example, to coerce the value
	*	to an int using Math.floor(), Math.ceil() or
	*	Math.round().
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public interface ITweenValueFormatter {
		
		/**
		*	Accepts the value of the property to be set
		*	and either returns the same value or modifies
		*	the value and returns the modified version.
		*
		*	@param value the value the property will be set to
		*
		*	@return an updated value for the property 
		*/
		function formatTweenValue( value:Number ):Number;
	}
}