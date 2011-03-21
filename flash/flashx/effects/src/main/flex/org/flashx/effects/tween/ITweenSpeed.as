package org.flashx.effects.tween {
	
	/**
	*	Describes the contract for instances that
	*	control the refresh rate and frame rate for
	*	an ITween.
	*
	*	Note that refreshRate and frameRate are co-dependent,
	*	updating one always updates the other.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public interface ITweenSpeed {
		
		/**
		*	Sets the number of milliseconds between attempts
		*	to update the properties of the target Object.
		*
		*	@param val the number of milliseconds between property updates 
		*/
		function set refreshRate( val:int ):void;
		
		/**
		*	Gets the refresh rate for this instance in milliseconds.
		*
		*	@return the refresh rate in milliseconds
		*/
		function get refreshRate():int;
		
		/**
		*	Sets the frame rate (number of frames per second)
		*	that this instance is running at.
		*
		*	@param val the frame rate for the instance
		*/
		function set frameRate( val:int ):void;
		
		/**
		*	Gets the frame rate this instance is running at.
		*
		*	@return the frame rate this instance is running at
		*/
		function get frameRate():int;
	}
	
}
