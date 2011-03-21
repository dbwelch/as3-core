package org.flashx.ui.graphics {
	
	/**
	*	Describes the contract for graphical elements
	*	that are aware of a gradient.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IGradientAware {
		
		/**
		*	The gradient assigned to this graphical element.	
		*/
		function get gradient():IGradient;
		function set gradient( gradient:IGradient ):void;
	}
}