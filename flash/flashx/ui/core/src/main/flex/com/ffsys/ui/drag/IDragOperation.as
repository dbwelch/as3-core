package com.ffsys.ui.drag {
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import com.ffsys.ui.core.IInteractiveComponent;
	
	/**
	*	Describes the contract for objects that encapsulate
	*	a drag operation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IDragOperation {
		
		/**
		*	The source component being dragged.
		*	
		*	If no drag operation is taking place
		*	this property will be null.
		*/
		function get source():IInteractiveComponent;
		
		/**
		*	The target sprite being dragged.
		*/
		function get target():Sprite;
		
		/**
		*	A rectangle that defines the drag bounds.
		*/
		function get bounds():Rectangle;
		function set bounds( bounds:Rectangle ):void;
		
		/**
		*	Whether the drag is locked to the center of
		*	the target.
		*/
		function get locked():Boolean;
		function set locked( locked:Boolean ):void;
		
		/**
		*	Determines whether this drag operation is currently dragging.
		*	
		*	@return Whether this drag operation is dragging.
		*/
		function get dragging():Boolean;
		
		/**
		*	Starts the drag operation.
		*	
		*	@param source The source component initiating
		*	the drag operation.
		*/
		function start( source:IInteractiveComponent ):void;
		
		/**
		*	Stops the drag operation.	
		*/
		function stop():void;
		
		/**
		*	The delay in milliseconds between when this
		*	drag operation will send drag notifications.
		*/
		function get delay():Number;
		function set delay( delay:Number ):void;
	}
}