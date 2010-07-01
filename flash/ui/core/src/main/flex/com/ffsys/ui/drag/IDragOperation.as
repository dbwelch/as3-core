package com.ffsys.ui.drag {
	
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
	}
}