package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that can
	*	dispose of encapsulated <code>BitmapData</code>.
	*	
	*	@see com.ffsys.core.Destroyer
	*	@see com.ffsys.io.loaders.resources.ImageResource
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.10.2007
	*/
	public interface IDispose {
		
		/**
		*	Performs disposal of any <code>BitmapData</code>
		*	data stored in memory.
		*/
		function dispose():void;
	}
	
}
