package com.ffsys.utils.bezier {
	
	import flash.events.EventDispatcher;	
	import flash.geom.Point;
	
	/**
	*	Abstract base class for all IBezierSpline classes
	*	and provides utility static methods for working with
	*	BezierPoint instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.08.2007
	*/
	public class BezierSpline extends EventDispatcher {
		
		public function BezierSpline()
		{
			super();
		}
		
		static private var curveAccuracy:int = 5;
		
		static private function bezierDistance(
			start:BezierPoint,
			end:BezierPoint,
			control:BezierPoint ):Number
		{
			var p:BezierPoint = start;
			var np:BezierPoint;
		
			var dx:Number = end.x - start.x;
			var dy:Number = end.y - start.y;
			
			var cx:Number = ( dx == 0 ) ? 0 : ( control.x - start.x ) / dx;
			var cy:Number = ( dy == 0 ) ? 0 : ( control.y - start.y ) / dy;
			
			var f1:Number;
			var f2:Number;
			var t:Number;
			var d:Number = 0;
			var i:int = 1;
			
			for( ; i < curveAccuracy;i++ )
			{
				t = i / curveAccuracy;
				
				f1 = 2 * t * ( 1 - t );
				f2 = t * t;
				
				np = new BezierPoint(
					start.x + dx * ( f1 * cx + f2 ),
					start.y + dy * ( f1 * cy + f2 )
				);
				
				d += BezierSpline.distance( p, np );
				p = np;
			}
			
			return d + BezierSpline.distance( p, end );
		}
		
		static public function angle( start:BezierPoint, end:BezierPoint ):Number
		{
			return Math.atan2( end.y - start.y, end.x - start.x );
		}		
		
		static public function interpolate(
			start:BezierPoint,
			end:BezierPoint,
			time:Number ):BezierPoint
		{
			var point:Point = Point.interpolate( start.point, end.point, time );
			return new BezierPoint( point.x, point.y );
		}
		
		static public function point(
			time:Number,
			start:BezierPoint,
			end:BezierPoint ):BezierPoint
		{
			return interpolate( start, end, time );
		}

		static public function distance(
			start:BezierPoint,
			end:BezierPoint,
			control:BezierPoint = null ):Number
		{
			
			if( !control )
			{
				return Point.distance( start.point, end.point );
			}
			
			return bezierDistance( start, end, control );
		}
		
	}
	
}
