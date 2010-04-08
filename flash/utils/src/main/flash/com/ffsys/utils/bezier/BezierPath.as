package com.ffsys.utils.bezier {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	*	Describes a Bezier path consisting of multiple
	*	Quadratic Bezier Splines.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class BezierPath extends EventDispatcher {
		
		protected var _start:BezierPoint;
		protected var _end:BezierPoint;
		protected var _splines:Array;
		
		public function BezierPath( start:BezierPoint = null, end:BezierPoint = null )
		{
			super();
			
			if( !start )
			{
				start = new BezierPoint( 0, 0 );
			}
			
			if( !end )
			{
				end = new BezierPoint( 100, 100 );
			}
			
			this.start = new BezierPoint( start.x, start.y );
			this.end = new BezierPoint( end.x, end.y );
			
			clear();
		}
		
		public function set start( val:BezierPoint ):void
		{
			_start = val;
		}
		
		public function get start():BezierPoint
		{
			return _start;
		}
		
		public function set end( val:BezierPoint ):void
		{
			_end = val;
		}
		
		public function get end():BezierPoint
		{
			return _end;
		}
		
		public function set splines( val:Array ):void
		{
			_splines = val;
		}
		
		public function get splines():Array
		{
			return _splines;
		}
		
		private function change( event:Event ):void
		{
			dispatchEvent( event );
		}
		
		public function addControlPoint( control:BezierPoint ):void
		{
			var interpolation:Number = 1;
			var interpolated:BezierPoint = this.start;
			
			if( getLength() )
			{
				interpolation = ( 1 / ( getLength() + 1 ) );
				
				trace( "addControlPoint interpolation : " + interpolation );
				
				//trace( "addControlPoint interpolation start x : " + this.start.x );
				//trace( "addControlPoint interpolation end x : " + this.end.x );
				
				var point:Point = Point.interpolate( this.start.point, this.end.point, interpolation );
				
				interpolated = new BezierPoint( point.x, point.y );
				
				trace( "addControlPoint interpolated x : " + interpolated.x );
				trace( "addControlPoint interpolated y : " + interpolated.y );				
			}
			
			var spline:IBezierSpline = new QuadraticBezierSpline(
				interpolated,
				this.end,
				control );
				
			spline.path = this;
			
			spline.addEventListener( Event.CHANGE, change );
				
			var length:int = _splines.push( spline );
			
			if( length > 1 )
			{
				_splines[ length - 2 ].end = interpolated;
			}
			
		}
		
		public function clear():void
		{
			_splines = new Array();
		}
		
		public function getLength():int
		{
			return _splines.length;
		}
		
		private var interpolation:int = 5;
		
		public function getSplinePoints( spline:IBezierSpline, quality:int = 100 ):Array
		{
			var output:Array = new Array();
			
			//trace( "getSplinePoints distance : " + spline.distance() );
			
			var distance:Number = spline.distance();
			var divider:Number = distance / interpolation;
			
			var i:int = 0;
			var l:int = quality;
			
			var multiplier:Number = ( 1 / quality );
			
			for( ;i <= l;i++ )
			{
				output.push( spline.point( multiplier * i ) );
			}
			
			return output;
		}
		
		public function getBezierPathPoints( quality:int = 100 ):Array
		{
			var i:int = 0;
			var l:int = getLength();
			
			//trace( "Spline length : " + l );
			
			var output:Array = new Array();
			
			for( ;i < l;i++ )
			{
				output = output.concat( getSplinePoints( _splines[ i ], quality ) );
			}
			
			return output;
		}
		
		/**
		*	Gets a point along a spline for a given time, time is from zero
		*	to one.
		*
		*	@param spline the IBezierSpline to find the point on
		*	@param time the time along the IBezierSpline to find the position of
		*
		*	@return the BezierPoint on a IBezierSpline for a given time (time is 0-1).
		*/
		static public function pointOnBezier( spline:IBezierSpline, time:Number ):BezierPoint
		{
			var x:Number = 0;
			var y:Number = 0;
			
			var p1x:Number = spline.start.x;
			var p1y:Number = spline.start.y;
			
			var p2x:Number = spline.end.x;
			var p2y:Number = spline.end.y;
			
			if( spline is IQuadraticBezierSpline )
			{
			
				var cx:Number = IQuadraticBezierSpline( spline ).control.x;
				var cy:Number = IQuadraticBezierSpline( spline ).control.y;
			
				x = p1x + time * ( 2 * ( 1 - time ) * ( cx - p1x ) + time * ( p2x - p1x ) );
				y = p1y + time * ( 2 * ( 1 - time ) * ( cy - p1y ) + time * ( p2y - p1y ) );
			
			}
			
			return new BezierPoint( x, y );
		}		
		
	}
	
}
