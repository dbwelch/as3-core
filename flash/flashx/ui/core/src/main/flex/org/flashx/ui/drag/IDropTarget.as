package org.flashx.ui.drag {
	
	/**
	*	Defines the contract for draggable components
	*	that can be the target for a drag and drop operation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IDropTarget {
		
		/**
		*	Determines whether this drop target
		*	accepts the target being dragged.
		*	
		*	@param target The target draggable component.
		*/
		function accepts( target:IDraggable ):Boolean;
		
		/**
		*	Invoked when the target draggable is dropped
		*	on this target if this drop target has accepted
		*	the drop operation.
		*	
		*	@param target The target draggable component.
		*/
		function dropped( target:IDraggable ):void;
	}
}