package org.flashx.ui.graphics
{

	/**
	*	Describes the contract for instances that provide
	* 	a method to draw graphics based on a specified
	*	width and height.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponentDraw
	{
		/**
		* 	Draws the graphics.
		*	
		*	@param width The width of the graphic.
		*	@param height The height of the graphic.
		*/
		function draw(
			width:Number = NaN, height:Number = NaN ):void;
	}
}