package com.ffsys.ui.layout {
	
	/**
	*	Describes the contract for instances that
	*	encapsulate the margin for a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IMargin extends IEdges {
		
		/**
		*	Updates the left, top, right and bottom margin
		*	to the same value.
		*	
		*	@param margin The margin for all edges.
		*/
		function set margin( margin:Number ):void;
	}
}