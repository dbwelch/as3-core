package com.ffsys.ui.graphics
{
	/**
	*	Represents a square component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class SquareGraphic extends RectangleGraphic
	{
		/**
		* 	Creates a <code>SquareGraphic</code> instance.
		* 
		* 	@param size The size of the square.
		*/
		public function SquareGraphic( size:Number = 25 )
		{
			super( size, size );
		}
	}
}