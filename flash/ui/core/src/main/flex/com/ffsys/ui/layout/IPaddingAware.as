package com.ffsys.ui.layout {
	
	/**
	*	Describes the contract for a component that
	*	is aware of padding values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IPaddingAware {
		
		/**
		*	The padding associated with this instance.
		*/
		function get padding():IPadding;
		function set padding( padding:IPadding ):void;
	}
}