package com.ffsys.ui.graphics
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
		* 
		* 	@param width The width of the ellipse.
		* 	@param height The height of the ellipse.
		*/
		public function EllipseGraphic(
			width:Number,
			height:Number,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( width, height, stroke, fill );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			graphics.drawEllipse( tx, ty, width, height );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return EllipseGraphic;
		}		
	}
}