package org.flashx.io.connection.flash {
	
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	*	Adds <code>IConnection</code> functionality
	*	to <code>NetStream</code>.
	*	
	*	By adhering to the <code>IConnection</code> interface
	*	<code>CoreNetStream</code> instances can
	*	be registered with the connection manager.
	*	
	*	@see com.ffsys.io.connection.IConnection
	*	@see com.ffsys.io.connection.ConnectionManager
	*	@see com.ffsys.io.connection.IConnectionManager
	*	@see com.ffsys.io.connection.flash.ICoreNetStream
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public class CoreNetStream extends NetStream
		implements ICoreNetStream {
		
		/**
		*	Creates a <code>CoreNetStream</code>
		*	instance.
		*	
		*	@param connection The <code>NetConnection</code>
		*	associated with this <code>CoreNetStream</code>.
		*/
		public function CoreNetStream(
			connection:NetConnection )
		{
			super( connection );
		}
	}
}