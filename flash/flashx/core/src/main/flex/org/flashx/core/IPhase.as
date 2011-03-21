package org.flashx.core {
	
	/**
	*	Describes the contract for instances that expose
	*	a <code>phase</code> property that describes the
	*	current <code>phase</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IPhase {
		
		/**
		*	The current <code>phase</code> for this
		*	instance.
		*/
		function set phase( val:String ):void;
		function get phase():String;		
	}
}