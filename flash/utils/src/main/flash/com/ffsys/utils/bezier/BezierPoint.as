package com.ffsys.utils.bezier {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	*	Encapsulates Point information and allows for
	*	BezierPath instances to know when the points
	*	on a path have changed.
	*
	*	Note that we can't extend Point as the x/y properties
	*	of Point are declared as public variables therefore
	*	there are no setters that can be overriden that would
	*	allow us to broadcast the CHANGE event.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.08.2007
	*/
	public class BezierPoint extends EventDispatcher {
		
		private var _point:Point;
		
		public function BezierPoint(
			x:Number = 0,
			y:Number = 0 )
		{
			super();
			_point = new Point( x, y );
		}
		
		public function get point():Point
		{
			return _point;
		}
		
		public function set x( val:Number ):void
		{
			_point.x = val;
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		public function get x():Number
		{
			return _point.x;
		}
		
		public function set y( val:Number ):void
		{
			_point.y = val;
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		public function get y():Number
		{
			return _point.y;
		}
		
	}
	
}
