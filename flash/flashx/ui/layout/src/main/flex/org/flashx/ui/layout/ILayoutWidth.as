package org.flashx.ui.layout {
	
	/**
	*	Describes the contract for objects that
	*	expose a property that returns the width
	*	to be used when laying out the display object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface ILayoutWidth {
		
		/**
		*	The width to use when this object is
		*	laid out.
		*/
		function get layoutWidth():Number;
	}
}