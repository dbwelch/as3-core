package com.ffsys.ui.graphics
{
	import flash.geom.Point;
	
	import com.ffsys.ui.common.Orientation;	
	
	/**
	*	Represents a rectangular component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class RectangleGraphic extends ComponentGraphic
		implements IPointerAwareGraphic
	{
		private var _pointer:IPointer;
		
		/**
		* 	Creates a <code>RectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*/
		public function RectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( width, height, stroke, fill );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get pointer():IPointer
		{
			return _pointer;
		}
		
		public function set pointer( value:IPointer ):void
		{
			_pointer = value;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( pointer == null )
			{
				graphics.drawRect( tx, ty, width, height );
			}else{
				//set up the default offset (centred) depending upon edge
				if( isNaN( pointer.offset ) )
				{
					
					/*
					trace("RectangleGraphic::doDraw(), setting default pointer offset: ",
						this, width, height, pointer.edge );
					*/
					
					if( pointer.edge == Orientation.TOP
					 	|| pointer.edge == Orientation.BOTTOM )
					{
						pointer.offset = width / 2;
					}else if(
						pointer.edge == Orientation.LEFT
						|| pointer.edge == Orientation.RIGHT )
					{
						pointer.offset = height / 2;
						
						/*
						trace("RectangleGraphic::doDraw(), setting vertical offset: ",
							pointer.offset, height );
						*/
					}
				}
				
				var sx:Number = tx;
				var sy:Number = ty;
				var w:Number = width;
				var h:Number = height;
				
				if( pointer.inside )
				{
					if( pointer.edge == Orientation.TOP
					 	|| pointer.edge == Orientation.BOTTOM )
					{
						h -= pointer.preferredHeight;
					}else if(
						pointer.edge == Orientation.LEFT
						|| pointer.edge == Orientation.RIGHT )
					{
						w -= pointer.preferredHeight;
					}
				
					if( pointer.edge == Orientation.TOP )
					{
						sy += pointer.preferredHeight;
					}
				
					if( pointer.edge == Orientation.LEFT )
					{
						sx += pointer.preferredHeight;
					}
				}
				
				drawPointerEdge(
					Orientation.TOP,
					pointer.edge,
					width,
					height,
					w,
					h,
					sx,
					sy );
					
				drawPointerEdge(
					Orientation.RIGHT,
					pointer.edge,
					width,
					height,
					w,
					h,
					sx,
					sy );
					
				drawPointerEdge(
					Orientation.BOTTOM,
					pointer.edge,
					width,
					height,
					w,
					h,
					sx,
					sy );
					
				drawPointerEdge(
					Orientation.LEFT,
					pointer.edge,
					width,
					height,
					w,
					h,
					sx,
					sy );					
			}
		}
		
		/**
		*	Draws an edge with a pointer.
		*	
		*	@param edge The edge to draw.
		*	@param orientation The orientation of the pointer.
		*	@param width The full width this graphic is drawing at.
		*	@param height The full height this graphic is drawing at.
		*	@param offsetWidth A width taking into account the pointer.
		*	@param offsetHeight A height taking into account the pointer.
		*	@param sx The start x coordinate for the top left corner.
		*	@param sy The start y coordinate for the top left corner.
		*/
		protected function drawPointerEdge(
			edge:String,
			orientation:String,
			width:Number,
			height:Number,
			offsetWidth:Number,
			offsetHeight:Number,
			sx:Number,
			sy:Number ):void
		{
			var start:Point = new Point();
			var end:Point = new Point();
			
			var halfWidth:Number = pointer.preferredWidth / 2;
			var halfHeight:Number = pointer.preferredHeight / 2;
			
			//the edge equals the orientation so draw the corner.
			if( edge == orientation )
			{
				switch( orientation )
				{
					case Orientation.TOP:
						start = new Point(
							sx + ( pointer.offset - halfWidth ), sy );
						end = new Point( sx + ( pointer.offset + halfWidth ), sy );
						moveTo( new Point( sx, sy ) );
						lineTo( start );
						pointer.drawPointer( this, start, end );
						lineTo( new Point( sx + offsetWidth, sy ) );
						break;
					case Orientation.RIGHT:
						start = new Point(
							sx + offsetWidth, sy + ( pointer.offset - halfWidth ) );
						end = new Point( sx + offsetWidth, sy + ( pointer.offset + halfWidth ) );
						lineTo( start );
						pointer.drawPointer( this, start, end );
						lineTo( new Point( sx + offsetWidth, sy + offsetHeight ) );
						break;
					case Orientation.BOTTOM:
						start = new Point(
							sx + ( pointer.offset + halfWidth ), sy + offsetHeight );
						end = new Point( sx + ( pointer.offset - halfWidth ), sy + offsetHeight );
						lineTo( start );
						pointer.drawPointer( this, start, end );
						lineTo( new Point( sx, sy + offsetHeight ) );
						break;
					case Orientation.LEFT:
						start = new Point(
							sx, sy + ( pointer.offset + halfWidth ) );
						end = new Point( sx, sy + ( pointer.offset - halfWidth ) );
						
						/*
						trace("RectangleGraphic::drawPointerEdge(), left: ", start, end );
						trace("RectangleGraphic::drawPointerEdge(), left: ", sx, sy, pointer.offset, halfWidth );
						*/
						
						lineTo( start );
						pointer.drawPointer( this, start, end );
						lineTo( new Point( sx, sy ) );
						break;
				}
			//draw the straight edges
			}else{
				switch( edge )
				{
					case Orientation.TOP:
						moveTo( new Point( sx, sy ) );
						lineTo( new Point( sx + offsetWidth, sy ) );
						break;
					case Orientation.RIGHT:
						lineTo( new Point( sx + offsetWidth, sy + offsetHeight ) );
						break;
					case Orientation.BOTTOM:
						lineTo( new Point( sx, sy + offsetHeight ) );
						break;
					case Orientation.LEFT:
						lineTo( new Point( sx, sy ) );
						break;
				}
			}
		}
	}
}