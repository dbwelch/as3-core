package com.ffsys.ui.graphics
{
	
	/**
	*	Represents a circular component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class CircleGraphic extends EllipseGraphic
	{
		/**
		* 	Creates a <code>CircleGraphic</code> instance.
		* 
		* 	@param diameter The diameter for the circle.
		*/
		public function CircleGraphic(
			diameter:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( diameter, diameter );
			this.stroke = stroke;
			this.fill = fill;
		}
	}
}