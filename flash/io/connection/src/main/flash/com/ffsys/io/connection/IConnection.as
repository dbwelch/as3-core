package com.ffsys.io.connection {
	
	import com.ffsys.io.core.IClose;
	
	/**
	*	Describes the contract for instances that
	*	encapsulate a connection.
	*	
	*	This can be a socket connection, local
	*	connection or any other sort of connection
	*	that can be closed.
	*	
	*	@see com.ffsys.io.core.IClose
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IConnection
		extends IClose {
	}
}