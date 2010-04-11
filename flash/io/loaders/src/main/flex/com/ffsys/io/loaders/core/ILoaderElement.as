package com.ffsys.io.loaders.core {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.connection.IConnection;
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Common type for instances that can
	*	exist in <code>ILoaderQueue</code> implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface ILoaderElement
		extends IConnection,
				IStringIdentifier,
				IEventDispatcher {
	}
}