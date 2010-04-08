package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for instances that
	*	can flush any resources that have been loaded.
	*	
	*	This will free up memory consumed by the loaded
	*	resources while leaving the underlying
	*	<code>ILoader</code> implementations that loaded
	*	the resources intact so they can easily be re-loaded
	*	when required.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.10.2007
	*/
	public interface IFlushResources {
		
		/**
		*	Flushes any loaded resources.
		*/
		function flushResources():void;
	}
}