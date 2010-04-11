package com.ffsys.io.loaders.display {
	
	import flash.display.BitmapData;
	
	/**
	*	Describes the contract for instances that can
	*	load bitmap data into them and be added to the
	*	display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public interface IDisplayImage extends IAbstractDisplay {
		
		/**
		*	Creates a clone of this <code>IDisplayImage</code>
		*	instance.
		*/
		function clone():IDisplayImage;
		
		/**
		*	The bitmap data that represents the image
		*	to be displayed.
		*/
		function set bitmapData( val:BitmapData ):void;
		function get bitmapData():BitmapData;
	}
}