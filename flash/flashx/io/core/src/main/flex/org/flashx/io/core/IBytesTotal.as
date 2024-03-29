package org.flashx.io.core {
	
	/**
	*	Describes the contract for implementations that expose 
	*	the total number of bytes.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public interface IBytesTotal {
		
		/**
		*	The total number of bytes.
		*/
		function set bytesTotal( val:uint ):void;
		function get bytesTotal():uint;
	}
}