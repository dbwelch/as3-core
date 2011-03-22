package org.flashx.ui.graphics {
	
	/**
	*	Describes the contract for graphics that are
	*	aware of an orientation to face towards.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.07.2010
	*/
	public interface IOrientationAware {
		
		/**
		*	Determines the orientation of a graphic.
		*	
		*	This is the direction that the graphic points towards.
		*/
		function get orientation():String;
		function set orientation( orientation:String ):void;		
		
	}
}