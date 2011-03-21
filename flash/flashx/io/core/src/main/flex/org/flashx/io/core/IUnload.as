package org.flashx.io.core {
	
	/**
	*	Describes the contract for implementations that can
	*	unload loaded content.
	*	
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2007
	*/
	public interface IUnload {
		
		/**
		*	Unloads loaded content.
		*/
		function unload():void;
	}
}