package com.ffsys.ui.common {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for objects that represent the
	*	four edges of a rectangle.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IEdges extends IEventDispatcher {
		/**
		*	A number associated with the left edge of the rectangle.	
		*/
		function get left():Number;
		function set left( left:Number ):void;
		
		/**
		*	A number associated with the top edge of the rectangle.	
		*/
		function get top():Number;
		function set top( top:Number ):void;
		
		/**
		*	A number associated with the right edge of the rectangle.	
		*/
		function get right():Number;
		function set right( right:Number ):void;
		
		/**
		*	A number associated with the bottom edge of the rectangle.
		*/
		function get bottom():Number;
		function set bottom( bottom:Number ):void;		
	}
}