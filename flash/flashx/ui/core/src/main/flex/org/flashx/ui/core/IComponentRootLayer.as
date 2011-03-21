package org.flashx.ui.core
{
	import flash.display.DisplayObject;
	
	import org.flashx.ui.tooltips.IToolTipManager;
	
	/**
	*	Describes the contract for components that encapsulate
	* 	the root layer of the display list hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public interface IComponentRootLayer extends IComponent
	{
		/**
		* 	The tooltip manager implementation responsible
		* 	for showing and hiding tooltips.
		*/
		function get tooltips():IToolTipManager;
		
		/**
		* 	Initializes this component with the root display object.
		* 
		* 	The behaviour is this method is to add this instance to
		* 	the root display object and hook in to display list events
		* 	to keep this instance at the highest depth of the display list
		* 	hierarchy.
		* 
		* 	@param root The root display object for the display list.
		* 
		* 	@return Whether the root layer was initialized correctly of not.
		*/
		function initialize( root:DisplayObject ):Boolean;
		
		/**
		* 	Determines whether the root component layer has been
		* 	initialized.
		*/
		function get initialized():Boolean;
	}
}