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
		private var _cornerWidth:Number = 0;
		private var _cornerHeight:Number = 0;
		
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
			cornerWidth:Number = 0,
			cornerHeight:Number = 0 )
		{
			super( width, height, stroke, fill );
			_corners = new Vector.<ICorner>( 4, true );
			_corners[ 0 ] = new Corner();
			_corners[ 1 ] = new Corner();
			_corners[ 2 ] = new Corner();
			_corners[ 3 ] = new Corner();
			
			if( cornerWidth > 0 )
			{
				this.cornerWidth = cornerWidth;
			}
			
			if( cornerHeight > 0 )
			{
				this.cornerHeight = cornerHeight;
			}
		}
		
		/**
		* 	A width to apply to all corners.
		*/
		public function get cornerWidth():Number
		{
			return _cornerWidth;
		}
		
		public function set cornerWidth( value:Number ):void
		{
			_corners[ 0 ].width = value;
			_corners[ 1 ].width = value;
			_corners[ 2 ].width = value;
			_corners[ 3 ].width = value;
			_cornerWidth = value;
		}
		
		/**
		* 	A height to apply to all corners.
		*/
		public function get cornerHeight():Number
		{
			return _cornerHeight;
		}
		
		public function set cornerHeight( value:Number ):void
		{
			_corners[ 0 ].height = value;
			_corners[ 1 ].height = value;
			_corners[ 2 ].height = value;
			_corners[ 3 ].height = value;
			_cornerHeight = value;
		}
		
		/**
		* 	The top left corner.
		*/
		public function get topLeftCorner():ICorner
		{
			return _corners[ 0 ];
		}
		
		public function set topLeftCorner( value:ICorner ):void
		{
			_corners[ 0 ] = value;
		}
		
		/**
		* 	The top right corner.
		*/
		public function get topRightCorner():ICorner
		{
			return _corners[ 1 ];
		}
		
		public function set topRightCorner( value:ICorner ):void
		{
			_corners[ 1 ] = value;
		}
		
		/**
		* 	The bottom right corner.
		*/
		public function get bottomRightCorner():ICorner
		{
			return _corners[ 2 ];
		}
		
		public function set bottomRightCorner( value:ICorner ):void
		{
			_corners[ 2 ] = value;
		}
		
		/**
		* 	The bottom left corner.
		*/
		public function get bottomLeftCorner():ICorner
		{
			return _corners[ 3 ];
		}
		
		public function set bottomLeftCorner( value:ICorner ):void
		{
			_corners[ 3 ] = value;
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
		*	Resets all corners to be empty. 
		*/
		public function reset():void
		{
			var corner:ICorner = null;
  			for( var i:int = 0;i < corners.length;i++ )
			{
				corner = corners[ i ];
				if( corner )
				{
					corner.reset();
				}
			}
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