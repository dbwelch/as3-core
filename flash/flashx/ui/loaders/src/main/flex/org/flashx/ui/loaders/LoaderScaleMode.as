package org.flashx.ui.loaders
{
	
	/**
	*	Encapsulates constants that represent how loaders
	* 	should respond to loaded content that exceeds the preferred
	* 	dimensions for the loader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class LoaderScaleMode extends Object
	{
		/**
		* 	A scale mode that indicates that neither the loader
		* 	or loaded content should be scaled.
		*/
		public static const NO_SCALE:String = "noScale";
		
		/**
		* 	A scale mode that indicates the loaded content should
		* 	be scaled down to fit the preferred dimensions of the loader
		* 	if the loaded content exceeds the preferred dimensions of the
		* 	loader.
		*/
		public static const SCALE_TO_FIT:String = "scaleToFit";
		
		/**
		* 	A scale mode that indicates the loader should resize to
		* 	fit the dimensions of the loaded content.
		*/
		public static const RESIZE_TO_FIT:String = "resizeToFit";
	}
}