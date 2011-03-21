package org.flashx.ui.core
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	/**
	*	Describes the contract for the view utilities that
	* 	are exposed to all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public interface IComponentViewUtils
	{
		/**
		*	Gets the root display object.
		* 
		* 	This allows components access to the root
		* 	display object when they are not on the display list. 	
		*/
		function get root():DisplayObject;
		
		/**
		*	Gets the stage display object.
		* 
		* 	This allows components access to the stage
		* 	display object when they are not on the display list. 
		*/
		function get stage():Stage;
		
		/**
		* 	The root component layer for components
		* 	that need to appear above all other display
		* 	list objects.
		*/
		function get layer():IComponentRootLayer;
		
		/**
		*	The renderer used to defer component drawing routines
		*	until the render method of the stage is invoked.
		*/
		function get renderer():IComponentRenderer;		
	}
}