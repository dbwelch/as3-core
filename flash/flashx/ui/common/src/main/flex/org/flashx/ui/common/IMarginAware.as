package org.flashx.ui.common {
	
	/**
	*	Describes the contract for a component that
	*	is aware of margin values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IMarginAware {
		
		/**
		*	The margins associated with this display object.
		*	
		*	These are used when a layout handles a display
		*	object that implements this interface.
		*/
		function get margins():IMargin;
		function set margins( value:IMargin ):void;
	}
}