package com.ffsys.io.loaders.types {
	
	import com.ffsys.io.loaders.display.IDisplayImage;
	
	/**
	*	Describes the contract for instances that offer
	*	access to a loaded image and the
	*	underlying <code>BitmapData</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IImageAccess {
		
		/**
		*	The <code>IDisplayImage</code> created
		*	when the loaded image became available.
		*	
		*	@return An <code>IDisplayImage</code>
		*	implementation.
		*/
		function get image():IDisplayImage;
	}
}