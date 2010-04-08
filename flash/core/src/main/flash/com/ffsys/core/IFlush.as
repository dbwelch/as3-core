package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that perform
	*	flushing of encapsulated data.
	*	
	*	Unlike <code>IDestroy</code>, usage of this interface
	*	implies that the methods and properties of the instance
	*	are still available for normal use.
	*	
	*	@see com.ffsys.core.IDestroy
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2007
	*/
	public interface IFlush {
		
		/**
		*	Purge stored data encapsulated by this instance,
		*	allowing the stored data to be freed for garbage
		*	collection.
		*/
		function flush():void;
	}
}