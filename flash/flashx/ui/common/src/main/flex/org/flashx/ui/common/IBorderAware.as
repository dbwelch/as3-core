package org.flashx.ui.common {
	
	/**
	*	Describes the contract for a component that
	*	is aware of a border.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public interface IBorderAware {
		
		/**
		*	A border associated with this instance.
		*/
		function get border():IBorder;
		function set border( value:IBorder ):void;
	}
}