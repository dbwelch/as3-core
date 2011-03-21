package org.flashx.ui.common {
	
	/**
	*	Describes the contract for instances that
	*	encapsulate the padding for a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IPadding extends IEdges {
		
		/**
		*	Updates the left, top, right and bottom padding
		*	to the same value.
		*	
		*	@param padding The padding for all edges.	
		*/
		function set padding( padding:Number ):void;
	}
}