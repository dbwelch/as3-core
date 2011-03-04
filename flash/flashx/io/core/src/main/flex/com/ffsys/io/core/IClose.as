package com.ffsys.io.core {
	
	/**
	*	Describes the contract for implementations that
	*	can close an open connection.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IClose {
		
		/**
		*	Closes all open connections.
		*/
		function close():void;
	}
}