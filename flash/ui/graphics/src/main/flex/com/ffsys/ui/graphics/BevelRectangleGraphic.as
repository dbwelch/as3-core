package com.ffsys.ui.graphics
{
	import flash.geom.Point;
	
	/**
	*	Represents a rectangle with bevel style corners.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class BevelRectangleGraphic extends CornerAwareRectangleGraphic
	{
		/**
		* 	Creates a <code>BevelRectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*	@param stroke The stroke for the rectangle.
		*	@param fill The fill for the stroke.
		*	@param cornerWidth The initial width for all corners.
		*	@param cornerHeight The initial height for all corners.
		*/
		public function BevelRectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			cornerWidth:Number = 5,
			cornerHeight:Number = 5 )
		{
			super( width, height, stroke, fill, cornerWidth, cornerHeight );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			//trace("BevelRectangleGraphic::doDraw(), ", hasCorners() );
			
			if( hasCorners() )
			{
				var topLeft:ICorner = corners[ 0 ];
				var topRight:ICorner = corners[ 1 ];
				var bottomRight:ICorner = corners[ 2 ];
				var bottomLeft:ICorner = corners[ 3 ];
				
				moveTo( new Point( topLeft.width, 0 ) );
				lineTo( new Point( width - topRight.width, 0 ) );
				lineTo( new Point( width, topRight.height ) );
				lineTo( new Point( width, height - bottomRight.height ) );
				lineTo( new Point( width - bottomRight.width, height ) );
				lineTo( new Point( bottomLeft.width, height ) );
				lineTo( new Point( 0, height - bottomLeft.height ) );
				lineTo( new Point( 0, topLeft.height ) );
				lineTo( new Point( topLeft.width, 0 ) );
			}else{
				super.doDraw( width, height );
			}
		}
	}
}