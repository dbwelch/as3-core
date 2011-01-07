package com.ffsys.ui.graphics
{
	import flash.geom.Point;
	
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
			cornerWidth:Number = 0,
			cornerHeight:Number = 0 )
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
				var topLeft:ICorner = corners[ 0 ];
				var topRight:ICorner = corners[ 1 ];
				var bottomRight:ICorner = corners[ 2 ];
				var bottomLeft:ICorner = corners[ 3 ];
				
				moveTo( new Point( topLeft.width, 0 ) );
				lineTo( new Point( width - topRight.width, 0 ) );
				curveTo( new Point( width, 0 ), new Point( width, topRight.height ) );
				lineTo( new Point( width, height - bottomRight.height ) );
				curveTo( new Point( width, height ),
					new Point( width - bottomRight.width, height ) );
				lineTo( new Point( bottomLeft.width, height ) );
				curveTo( new Point( 0, height ),
					new Point( 0, height - bottomLeft.height ) );
				lineTo( new Point( 0, topLeft.height ) );
				curveTo( new Point( 0, 0 ),
					new Point( topLeft.width, 0 ) );
			}else
			{
				super.doDraw( width, height );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return RoundedRectangleGraphic;
		}
	}
}