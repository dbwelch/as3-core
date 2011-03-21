package org.flashx.ui.drag {
	
	/**
	*	Defines the contract for draggable components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IDraggable {
		
		/**
		*	Invoked by the drag operation while this
		*	draggable is being dragged.
		*	
		*	@param drag The drag operation performing the drag.
		*/
		function dragUpdate( drag:IDragOperation ):void;
	}
}