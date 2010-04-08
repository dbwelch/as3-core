package com.ffsys.utils.bezier {
	
	import flash.events.Event;	
	import flash.geom.Point;
	
	/**
	*	Represents an individual segment of a bezier path
	*	as a Quadratic Bezier Spline.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class QuadraticBezierSpline extends LinearBezierSpline
		implements IQuadraticBezierSpline {
		
		private var _control:BezierPoint;
		
		public function QuadraticBezierSpline(
			start:BezierPoint = null,
			end:BezierPoint = null,
			control:BezierPoint = null )
		{
			super( start, end );
			
			if( !control )
			{
				control = new BezierPoint( 50, 50 );
			}
			
			this.control = control;
		}
		
		public function set control( val:BezierPoint ):void
		{
			if( _control )
			{
				_control.removeEventListener( Event.CHANGE, change );
			}			
			
			_control = val;
			
			_control.addEventListener( Event.CHANGE, change, false, 0, true );
		}
		
		public function get control():BezierPoint
		{
			return _control;
		}
		
		override public function point( time:Number ):BezierPoint
		{
			var p1:BezierPoint = BezierSpline.interpolate( control, start, time );
			var p2:BezierPoint = BezierSpline.interpolate( end, control, time );

			return BezierSpline.interpolate( p2, p1, time );
		}
		
		override public function distance():Number
		{
			return BezierSpline.distance( start, end, control );
		}
		
		override public function angle( time:Number = 0 ):Number
		{
			var p1:BezierPoint = BezierSpline.point( time, start, control );
			var p2:BezierPoint = BezierSpline.point( time, control, end );
			return BezierSpline.angle( p1, p2 );
		}
		
	}
	
}
