package com.ffsys.ui.tooltips
{
	import com.ffsys.ui.core.IComponent;
	
	/**
	*	Describes the contract for instances that manage
	* 	component tooltips.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public interface IToolTipManager extends IComponent
	{
		/**
		* 	The renderer instance to use when rendering tooltips.
		*/
		function get renderer():IToolTipRenderer;
		function set renderer( renderer:IToolTipRenderer ):void;
		
		/**
		* 	The preferred alignment of the tooltip relative
		* 	to the mouse cursor.
		* 
		* 	This actual value used for alignment when positioning the tooltip
		* 	may automatically be changed if the positioning of the tooltip would cause
		* 	it to be clipped by the stage.
		*/
		function get align():String;
		function set align( align:String ):void;
		
		/**
		* 	Shows a tooltip with the specified text.
		* 
		* 	If the tooltip renderer exists and is on the display
		* 	list it's update method is invoked otherwise all references
		* 	are set on the tooltip, then it is addded to the display list
		* 	before the show method is invoked on the renderer.
		* 
		* 	@param text The text for the tooltip to display.
		*/
		function show( text:String ):void;
		
		/**
		*	Hides the tooltip.
		* 
		* 	By default if the tooltip renderer is on the display list
		* 	this method will invoke the hide method of the renderer to
		* 	defer responsbility for hiding to the tooltip.
		* 
		* 	If the renderer is not on the display list this method will
		* 	have no effect. 
		*/
		function hide():void;
		
		/**
		* 	Invoked by the tooltip renderer to inform the manager
		* 	that the tooltip has been hidden.
		*/
		function hidden():void;
		
		/**
		* 	Invoked by the tooltip renderer to inform the manager
		* 	that the tooltip has been shown.
		*/
		function shown():void;
	}
}