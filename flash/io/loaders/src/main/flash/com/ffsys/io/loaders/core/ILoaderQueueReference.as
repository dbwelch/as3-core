package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for instances that
	*	maintain a reference to an
	*	<code>ILoaderQueue</code> implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2007
	*/
	public interface ILoaderQueueReference {
		
		/**
		*	The <code>ILoaderQueue</code> implementation
		*	associated with this instance.	
		*/
		function set queue( val:ILoaderQueue ):void;
		function get queue():ILoaderQueue;
	}
}