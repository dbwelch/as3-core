package org.flashx.ui.display
{
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	import org.flashx.io.loaders.core.ILoader;
	import org.flashx.ui.buttons.IButton;
	
	/**
	*	Describes the contract for implementations
	* 	that display a bitmap image.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public interface IImageDisplay extends IButton
	{
		/**
		* 	The image being displayed.
		* 
		* 	If an image has been loaded into
		* 	this implementation this property
		* 	will be of <code>Bitmap</code> type.
		*/
		function get image():DisplayObject;
		function set image( value:DisplayObject ):void;
		
		/**
		* 	Loads an image into this image display.
		* 
		* 	@param request The url request.
		* 
		* 	@return The loader implementation handling the image load.
		*/
		function getLoader( request:URLRequest ):ILoader;
	}
}