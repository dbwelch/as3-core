package com.ffsys.utils.bezier {
	
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	*	Describes a cubic Bezier curve, currently not implemented.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.08.2007
	*/
	public class CubicBezierSpline extends QuadraticBezierSpline {
		
		private var _cubic:BezierPoint;
		
		public function CubicBezierSpline(
			start:BezierPoint = null,
			end:BezierPoint = null,
			control:BezierPoint = null,
			cubic:BezierPoint = null )
		{
			super( start, end, control );
			
			if( !cubic )
			{
				cubic = new BezierPoint( 25, 25 );
			}
	
			this.cubic = cubic;
		}
		
		public function set cubic( val:BezierPoint ):void
		{
			if( _cubic )
			{
				_cubic.removeEventListener( Event.CHANGE, change );
			}
			
			_cubic = val;
			_cubic.addEventListener( Event.CHANGE, change, false, 0, true );
		}
		
		public function get cubic():BezierPoint
		{
			return _cubic;
		}		
		
	}
	
}
