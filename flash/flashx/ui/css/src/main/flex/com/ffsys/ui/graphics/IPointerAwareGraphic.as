package com.ffsys.ui.graphics {
	
	/**
	*	Describes the contract for graphics that are
	*	aware of a pointer.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.07.2010
	*/
	public interface IPointerAwareGraphic
		extends IComponentGraphic {
		
		/**
		*	A pointer associated with this graphic.	
		*/
		function get pointer():IPointer;
		function set pointer( value:IPointer ):void;
	}
}