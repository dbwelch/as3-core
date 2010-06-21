package com.ffsys.ui.graphics
{
	/**
	*	Abstract super class to represent a rectangle
	*	that has custom corners.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class CornerAwareRectangleGraphic extends RectangleGraphic
	{
		private var _corners:Vector.<ICorner>;
		
		/**
		* 	Creates a <code>CornerAwareRectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*	@param stroke The stroke for the rectangle.
		*	@param fill The fill for the stroke.
		*	@param cornerWidth The width of the corner.
		*	@param cornerHeight The height of the corner.
		*/
		public function CornerAwareRectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			cornerWidth:Number = 2,
			cornerHeight:Number = NaN )
		{
			super( width, height, stroke, fill );
			_corners = new Vector.<ICorner>( 4, true );
			_corners[ 0 ] = new Corner( cornerWidth, cornerHeight );
			_corners[ 1 ] = new Corner( cornerWidth, cornerHeight );
			_corners[ 2 ] = new Corner( cornerWidth, cornerHeight );
			_corners[ 3 ] = new Corner( cornerWidth, cornerHeight );
		}
		
		/**
		*	The corners for the rectangle.
		*	
		*	This is a vector with a fixed length of four
		*	and each index represents a corner of the graphic.
		*	
		*	The index order for corner lookup is clockwise.
		*	Top left (index 0) followed by top right (index 1),
		*	bottom right (index 2) and bottom left (index 3).
		*/
		public function get corners():Vector.<ICorner>
		{
			return _corners;
		}
		
		/**
		*	Performs a solo operation on the corner at
		*	the specified index by resetting all other corners.
		*	
		*	If the specified index of out of bounds this method will
		*	have no effect.
		*	
		*	@param index The index of the only corner to draw.
		*/
		public function solo( index:uint ):void
		{
			var corner:ICorner = null;
			for( var i:int = 0;i < corners.length;i++ )
			{
				corner = corners[ i ];
				if( i != index && corner )
				{
					corner.reset();
				}
			}
		}
		
		/**
		*	Determines whether any custom corners have been specified
		*	for this graphic.
		*	
		*	@return Whether the corners vector contains any non-empty
		*	corner instances.
		*/
		public function hasCorners():Boolean
		{
			var found:Boolean = false;
			var corner:ICorner = null;
  			for( var i:int = 0;i < corners.length;i++ )
			{
				corner = corners[ i ];
				if( corner && !corner.isEmpty() )
				{
					found = true;
					break;
				}
			}
			return found;
		}
	}
}