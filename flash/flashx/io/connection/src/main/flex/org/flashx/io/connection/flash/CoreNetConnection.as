package org.flashx.io.connection.flash {
	
	import flash.net.NetConnection;
	
	/**
	*	Adds <code>IConnection</code> functionality
	*	to <code>NetConnection</code>.
	*	
	*	By adhering to the <code>IConnection</code> interface
	*	<code>CoreNetConnection</code> instances can
	*	be registered with the connection manager.
	*	
	*	@see com.ffsys.io.connection.IConnection
	*	@see com.ffsys.io.connection.ConnectionManager
	*	@see com.ffsys.io.connection.IConnectionManager
	*	@see com.ffsys.io.connection.flash.ICoreNetConnection
	*	
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public class CoreNetConnection extends NetConnection
		implements ICoreNetConnection {
		
		/**
		*	Creates a <code>CoreNetConnection</code>
		*	instance.
		*/
		public function CoreNetConnection()
		{
			super();
		}
	}
}