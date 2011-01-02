package com.ffsys.ui.graphics
{
	import flash.display.LineScaleMode;
	
	/**
	*	Represents a gradient stroke.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public class GradientStroke extends Stroke
	{
		
		/**
		* 	Creates a <code>GradientStroke</code> instance.
		* 
		* 	@param gradient The gradient to use for the stroke.
		* 	@param thickness The stroke thickness.
		* 	@param pixelHinting Whether pixel hinting is enabled.
		* 	@param scaleMode The scale mode.
		* 	@param caps The caps mode.
		* 	@param joints The mode for joint rendering.
		* 	@param miterLimit The miter limit.
		*/
		public function GradientStroke(
			gradient:IGradient = null,
			thickness:Number = 1,
			pixelHinting:Boolean = true,
			scaleMode:String = LineScaleMode.NORMAL,
			caps:String = null,
			joints:String = null,
			miterLimit:Number = 3 )
		{
			super( thickness, 0, 1, pixelHinting, scaleMode, caps, joints, miterLimit );
			this.gradient = gradient;
		}
	}
}