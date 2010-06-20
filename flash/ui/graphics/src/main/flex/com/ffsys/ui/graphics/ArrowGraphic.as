package com.ffsys.ui.graphics {
	
	import flash.geom.Point;
	
	/**
	*	Represents an arrow.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class ArrowGraphic extends TriangleGraphic {
		
		/**
		*	Creates an <code>ArrowGraphic</code> instance.
		*	
		*	@param width The width of the arrow.
		*	@param height The height of the arrow.
		*	@param stroke A stroke for the graphic.
		*	@param fill A fill for the graphic.
		*/
		public function ArrowGraphic(
			width:Number = 10,
			height:Number = 10,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( stroke, fill );
			this.preferredWidth = width;
			this.preferredHeight = height;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			this.point1 = new Point();
			this.point2 = new Point( width, height / 2 );
			this.point3 = new Point( 0, height );
			
			super.doDraw( width, height );
		}
	}
}