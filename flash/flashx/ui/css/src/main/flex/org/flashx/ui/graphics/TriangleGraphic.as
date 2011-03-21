package org.flashx.ui.graphics {
	
	import flash.geom.Point;
	
	/**
	*	Represents a triangle graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class TriangleGraphic extends ComponentGraphic {
		
		private var _point1:Point;
		private var _point2:Point;
		private var _point3:Point;
		
		/**
		*	Creates a <code>TriangleGraphic</code> instance.
		*	
		*	@param stroke The stroke for the graphic.
		*	@param fill The fill for the graphic.
		*	@param point1 The first point of the triangle.
		*	@param point2 The second point of the triangle.
		*	@param point3 The third point of the rectangle.
		*/
		public function TriangleGraphic(
			stroke:IStroke = null,
			fill:IFill = null,
			point1:Point = null,
			point2:Point = null,
			point3:Point = null )
		{
			super( 0, 0, stroke, fill );
			this.point1 = point1;
			this.point2 = point2;
			this.point3 = point3;
		}
		
		/**
		*	The first point of the triangle.	
		*/
		public function get point1():Point
		{
			return _point1;
		}
		
		public function set point1( point:Point ):void
		{
			_point1 = point;
		}
		
		/**
		*	The second point of the triangle.	
		*/		
		public function get point2():Point
		{
			return _point2;
		}

		public function set point2( point:Point ):void
		{
			_point2 = point;
		}
		
		/**
		*	The third point of the triangle.
		*/
		public function get point3():Point
		{
			return _point3;
		}

		public function set point3( point:Point ):void
		{
			_point3 = point;
		}

		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( point1 && point2 && point3 )
			{
				graphics.moveTo( point1.x, point1.y );
				graphics.lineTo( point2.x, point2.y );
				graphics.lineTo( point3.x, point3.y );
				graphics.lineTo( point1.x, point1.y );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function afterDraw( width:Number, height:Number ):void
		{
			super.afterDraw( width, height );
			this.preferredWidth = this.width;
			this.preferredHeight = this.height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return TriangleGraphic;
		}
	}
}