package com.ffsys.core.processor {
	
	import com.ffsys.core.IStrictMode;
	
	/**
	*	Describes the methods and properties
	*	for instances that represent a property
	*	lookup hierarchy for an address space.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.09.2007
	*/
	public interface IProcessorAddressSpace
		extends IStrictMode {
		
		/**
		*	The root instance that processing
		*	should begin from.
		*/
		function set root( root:IRootAddress ):void;
		function get root():IRootAddress;
		
		/**
		*	@deprecate
		*/
		function set lookup( val:Boolean ):void;
		function get lookup():Boolean;
	}
}