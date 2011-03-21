package org.flashx.io.connection {
	
	import org.flashx.io.connection.flash.ICoreNetStream;
	
	/**
	*	Describes the contract for instances
	*	that can register an <code>ICoreNetStream</code>
	*	with an underlying <code>IConnectionManager</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IRegisterCoreNetStream {

		/**
		*	Registers an <code>ICoreNetStream</code>
		*	with this instance.
		*	
		*	@param stream The stream to register.
		*/		
		function registerCoreNetStream(
			stream:ICoreNetStream = null ):ICoreNetStream;
	}
}