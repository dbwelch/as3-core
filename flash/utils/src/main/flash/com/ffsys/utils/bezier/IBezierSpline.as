package com.ffsys.utils.bezier {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Common type for all Bezier splines.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.08.2007
	*/
	public interface IBezierSpline extends IEventDispatcher {
		
		function set path( val:BezierPath ):void;
		function get path():BezierPath;		
		
		function set start( val:BezierPoint ):void;
		function get start():BezierPoint;
		
		function set end( val:BezierPoint ):void;
		function get end():BezierPoint;
		
		function distance():Number;
		function point( time:Number ):BezierPoint;
		function angle( time:Number = 0 ):Number;
	}
	
}
