package com.ffsys.ui.graphics
{
	/**
	*	Draws a rounded rectangle using the standard
	*	drawing api when no corners have been specified
	*	otherwise uses a custom drawing routine to enable
	*	the ability to only draw certain corners.
	*	
	*	This class implementation first checks for any
	*	custom corners, if so a custom drawing routine is
	*	used, otherwise if the corner width and height have been
	*	specified to non-zero values the usual flash
	*	drawing API method is invoked with the corner
	*	width and height used as the ellipse width and height.
	*	
	*	Finally, if no valid corner values are found a plain
	*	rectangle will be drawn.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class RoundedRectangleGraphic extends CornerAwareRectangleGraphic
	{
		/**
		* 	Creates a <code>RoundedRectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*	@param stroke The stroke for the rectangle.
		*	@param fill The fill for the stroke.
		*	@param cornerWidth The width of the corner.
		*	@param cornerHeight The height of the corner.
		*/
		public function RoundedRectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			cornerWidth:Number = 2,
			cornerHeight:Number = NaN )
		{
			super( width, height, stroke, fill, cornerWidth, cornerWidth );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( hasCorners() )
			{
				//TODO: implement
			}
		}
	}
}