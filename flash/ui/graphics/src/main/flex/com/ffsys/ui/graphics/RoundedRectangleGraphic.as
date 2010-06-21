package com.ffsys.ui.graphics
{
	/**
	*	Draws a rounded rectangle using the standard
	*	drawing api when no corners have been omitted
	*	.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class RoundedRectangleGraphic extends RectangleGraphic
	{
		private var _ellipseWidth:Number;
		private var _ellipseHeight:Number;
		
		/**
		* 	Creates a <code>RoundedRectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*	@param stroke The stroke for the rectangle.
		*	@param fill The fill for the stroke.
		*/
		public function RoundedRectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			ellipseWidth:Number = 2,
			ellipseHeight:Number = NaN )
		{
			super( width, height, stroke, fill );
			this.ellipseWidth = ellipseWidth;
			this.ellipseHeight = ellipseHeight;
		}
		
		/**
		*	The width of the ellipse to use when drawing
		*	the rounded corners.	
		*/
		public function get ellipseWidth():Number
		{
			return _ellipseWidth;
		}
		
		public function set ellipseWidth( value:Number ):void
		{
			_ellipseWidth = value;
		}
		
		/**
		*	The height of the ellipse to use when drawing
		*	the rounded corners.
		*/
		public function get ellipseHeight():Number
		{
			return _ellipseHeight;
		}
		
		public function set ellipseHeight( value:Number ):void
		{
			_ellipseHeight = value;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			graphics.drawRoundRect( tx, ty, width, height, ellipseWidth, ellipseHeight );
		}
	}
}