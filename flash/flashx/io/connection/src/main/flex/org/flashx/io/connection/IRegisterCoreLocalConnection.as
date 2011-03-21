package org.flashx.io.connection {
	
	import org.flashx.io.connection.flash.ICoreLocalConnection;
	
	/**
	*	Describes the contract for instances
	*	that can register an <code>ICoreLocalConnection</code>
	*	with an underlying <code>IConnectionManager</code>.
	*	
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IRegisterCoreLocalConnection {
		
		/**
		*	Registers an <code>ICoreLocalConnection</code>
		*	with this instance.
		*	
		*	@param connection The local connection to register.
		*/		
		function registerCoreLocalConnection(
			connection:ICoreLocalConnection = null ):ICoreLocalConnection;
	}
}