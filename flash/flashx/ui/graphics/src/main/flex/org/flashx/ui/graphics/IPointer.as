package org.flashx.ui.graphics {
	
	import flash.display.Graphics;
	import flash.geom.Point;	
	
	/**
	*	Common type to represent pointers that are abstract
	*	representations of a pointer that should be used during
	*	another graphic's drawing routine.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.07.2010
	*/
	public interface IPointer
		extends IComponentGraphic,
		 		IOrientationAware {
		
		/**
		*	Draws this pointer into the target graphics.
		*	
		*	@param graphic The component graphic to draw into.
		*	@param start The start point for the pointer.
		*	@param end The end pointer for the pointer.
		*/
		function drawPointer(
			graphic:IComponentGraphic, start:Point, end:Point ):void;
		
		/**
		*	An offset from the nearest left or upper corner
		*	depending upon the edge this pointer is aligned to.
		*	
		*	If the edge orientation is top the offset is from
		*	the top left corner. If the edge orientation is bottom the
		*	offset is from the bottom left corner.
		*	
		*	If the edge orientation is left the offset is from the
		*	top left corner while if the edge orientation is right
		*	the offset is from the top right corner.
		*	
		*	The offset is measured to the centre point of the pointer.
		*/
		function get offset():Number;
		function set offset( value:Number ):void;
		
		/**
		*	An edge this pointer is aligned to.
		*/
		function get edge():String;
		function set edge( value:String ):void;
		
		/**
		*	Determines whether the pointer should be drawn
		*	inside the bounds of the component graphic it
		*	is associated with. The default value is true.
		*/
		function get inside():Boolean;
		function set inside( value:Boolean ):void;				
	}
}