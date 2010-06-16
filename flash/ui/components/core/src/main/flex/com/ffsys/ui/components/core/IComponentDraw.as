package com.ffsys.ui.components.core
{

	/**
	*	Describes the contract for instances that provide
	* 	a method to draw graphics or layout child components
	* 	based on a specified width and height.
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
		* 	Draws the graphics for the component.
		*/
		function draw( width:Number = NaN, height:Number = NaN ):void;
	}
}