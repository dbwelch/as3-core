package com.ffsys.io.connection {
	
	import com.ffsys.io.connection.IConnection;
	
	/**
	*	Describes the contract for objects that can register
	*	an <code>IConnection</code> with an underlying <code>IConnectionManager</code>
	*	instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IRegisterConnection {
		
		/**
		*	Registers an <code>IConnection</code>
		*	with this instance.
		*	
		*	@param connection The connection to register.
		*/		
		function registerConnection(
			connection:IConnection = null ):IConnection;
	}
}