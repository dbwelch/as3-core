package com.ffsys.ui.components.graphics
{
	/**
	*	Represents an elliptical component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class EllipseGraphic extends ComponentGraphic
	{
		/**
		* 	Creates a <code>EllipseGraphic</code> instance.
		*/
		public function EllipseGraphic()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			graphics.drawEllipse( tx, ty, width, height );
		}
	}
}