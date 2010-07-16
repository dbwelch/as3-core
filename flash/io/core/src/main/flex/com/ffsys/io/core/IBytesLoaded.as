package com.ffsys.io.core {
	
	/**
	*	Describes the contract for implementations that expose
	*	the number of bytes loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public interface IBytesLoaded {
		
		/**
		*	The number of bytes loaded.
		*/		
		function set bytesLoaded( val:uint ):void;
		function get bytesLoaded():uint;
	}
}