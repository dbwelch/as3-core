package com.ffsys.ui.graphics
{
	
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
	{
		
		/**
		* 	Creates a <code>RectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*/
		public function RectangleGraphic(
			width:Number = 25,
			height:Number = 25 )
		{
			super( width, height );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			graphics.drawRect( tx, ty, width, height );
		}
	}
}