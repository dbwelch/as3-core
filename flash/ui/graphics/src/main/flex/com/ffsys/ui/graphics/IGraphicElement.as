package com.ffsys.ui.graphics
{
	import flash.display.Graphics;
	
	/**
	*	Common type for all graphic elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IGraphicElement
	{
		/**
		* 	Applies the stroke or fill to a graphics instance.
		*	
		*	@param graphics The graphics to draw to.
		*	@param component The component graphic encapsulating the
		*	shape of the graphic.
		*/
		function apply(
			graphics:Graphics,
			component:IComponentGraphic,
			width:Number,
			height:Number):void;
	}
}