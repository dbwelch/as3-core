package org.flashx.ui.tooltips
{
	import org.flashx.ui.core.IComponent;
	import org.flashx.ui.graphics.IPointer;
	import org.flashx.ui.graphics.IPointerAwareGraphic;
	
	/**
	*	Describes the contract for tooltip renderers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public interface IToolTipRenderer extends IComponent
	{
		/**
		*	A pointer to associate with the tooltip.	
		*/
		function get pointer():IPointer;
		function set pointer( value:IPointer ):void;
		
		/**
		*	The graphic to use for the tooltip background.
		*/
		function get graphic():IPointerAwareGraphic;
		function set graphic( value:IPointerAwareGraphic ):void;
		
		/**
		*	The tooltip manager responsbile for showing and
		* 	hiding tooltips.
		*/
		function get manager():IToolTipManager;
		function set manager( manager:IToolTipManager ):void;
		
		/**
		* 	The text assigned to the tooltip.
		*/
		function get text():String;
		function set text( text:String ):void;
		
		/**
		*	A maximum width for the text in the tooltip.
		*/
		function get maximumTextWidth():Number;
		function set maximumTextWidth( value:Number ):void;
		
		/**
		*	A maximum height for the text in the tooltip.
		*/
		function get maximumTextHeight():Number;
		function set maximumTextHeight( value:Number ):void;		
		
		/**
		* 	Display this tooltip.
		* 
		* 	@param text The text to display for the tooltip.
		*/
		function show( text:String ):void;
		
		/**
		* 	Hide this tooltip.
		*/
		function hide():void;
		
		/**
		* 	Updates this tooltip with new text to display.
		* 
		* 	This method will be invoked if the tooltip if on
		* 	the display list when the manager attempts to 
		* 	show a tooltip.
		* 
		* 	@param text The new text for the tooltip.
		*/
		function update( text:String ):void;
	}
}