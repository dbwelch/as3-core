package org.flashx.ui.common
{
	/**
	*	Describes the contract for components that are selectable.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public interface ISelectable
	{
		/**
		* 	Determines whether this component is selected.
		*/
		function get selected():Boolean;
		function set selected( selected:Boolean ):void;
	}
}