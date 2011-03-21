package org.flashx.core
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	import flash.geom.Matrix;
	
	/**
	*	Describes the contract for instances that provide a means
	* 	to capture a bitmap grab of their pixels.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IBitmapGrab
	{
		/**
		*	@inheritDoc	
		*/
		function getBitmap( target:DisplayObject = null, matrix:Matrix = null ):Bitmap;
	}
}