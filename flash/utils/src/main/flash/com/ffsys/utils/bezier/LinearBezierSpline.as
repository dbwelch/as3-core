package com.ffsys.utils.bezier {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	
	import flash.geom.Point;
	
	/**
	*	Represents an individual segment of a bezier path
	*	as a Linear Bezier Spline.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class LinearBezierSpline extends BezierSpline
		implements IBezierSpline {
		
		private var _path:BezierPath;
		private var _start:BezierPoint;
		private var _end:BezierPoint;
		
		public function LinearBezierSpline(
			start:BezierPoint = null,
			end:BezierPoint = null )
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
			
			this.start = start;
			this.end = end;
		}
		
		public function set path( val:BezierPath ):void
		{
			_path = val;
		}
		
		public function get path():BezierPath
		{
			return _path;
		}
		
		protected function change( event:Event ):void
		{
			dispatchEvent( event );
		}
		
		public function set start( val:BezierPoint ):void
		{
			if( _start )
			{
				_start.removeEventListener( Event.CHANGE, change );
			}
			
			_start = val;
			
			_start.addEventListener( Event.CHANGE, change, false, 0, true );
		}
		
		public function get start():BezierPoint
		{
			return _start;
		}
		
		public function set end( val:BezierPoint ):void
		{
			if( _end )
			{
				_end.removeEventListener( Event.CHANGE, change );
			}			
			
			_end = val;
			
			_end.addEventListener( Event.CHANGE, change, false, 0, true );
		}
		
		/**
		*	Gets the end BezierPoint for this Spline.
		*
		*	@return the end BezierPoint for this Spline
		*/
		public function get end():BezierPoint
		{
			return _end;
		}
		
		/**
		*	Gets the distance of the path for this Spline.
		*
		*	@return the distance between the start and end BezierPoints for this Spline
		*/
		public function distance():Number
		{
			return BezierSpline.distance( start, end );
		}
		
		public function point( time:Number ):BezierPoint
		{	
			return BezierSpline.interpolate( start, end, time );
		}
		
		public function angle( time:Number = 0 ):Number
		{
			return BezierSpline.angle( start, end );
		}
		
	}
	
}
