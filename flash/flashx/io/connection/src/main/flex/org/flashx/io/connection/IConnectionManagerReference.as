package org.flashx.io.connection {
	
	/**
	*	Describes the contract for instances that maintain
	*	a reference to an <code>IConnectionManager</code>.
	*	
	*	@see com.ffsys.io.connection.ConnectionManager
	*	@see com.ffsys.io.connection.IConnectionManager
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IConnectionManagerReference {
		
		/**
		*	A composite <code>IConnectionManager</code>.
		*/
		function set connectionManager(
			val:IConnectionManager ):void;
		function get connectionManager():IConnectionManager;
	}
}