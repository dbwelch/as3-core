package com.ffsys.ui.components.graphics
{
	import flash.display.Graphics;
	
	/**
	*	Common type for all graphic fills.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IGraphicFill
	{
		
		/**
		* 	Applies the fill to a graphics instance.
		*/
		function apply( graphics:Graphics ):void;
	}
}