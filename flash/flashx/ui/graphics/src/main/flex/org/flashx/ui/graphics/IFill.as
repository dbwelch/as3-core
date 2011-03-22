package org.flashx.ui.graphics {
	
	import org.flashx.core.IClone;	
	
	/**
	*	Common type for all fills.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IFill
		extends IGraphicElement,
		 		IClone {
			
		/**
		* 	Creates a clone of this fill.
		* 
		* 	@return A clone of this fill.
		*/
		function clone():IFill;
	}
}