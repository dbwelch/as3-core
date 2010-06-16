package com.ffsys.ui.components.graphics
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
		*/
		public function RectangleGraphic()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			graphics.drawRect( 0, 0, width, height );
		}
	}
}