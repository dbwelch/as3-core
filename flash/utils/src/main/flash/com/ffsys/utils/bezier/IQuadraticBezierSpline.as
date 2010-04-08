package com.ffsys.utils.bezier {
	
	/**
	*	Common type for classes that encapsulate data
	*	about a Bezier curve with a single control point.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.08.2007
	*/
	public interface IQuadraticBezierSpline extends IBezierSpline {
		function set control( val:BezierPoint ):void;
		function get control():BezierPoint;
	}
	
}
