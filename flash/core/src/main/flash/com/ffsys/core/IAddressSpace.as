package com.ffsys.core {
	
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.core.IType;
	
	/**
	*	Describes the contract for instances that represent
	*	an address space.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IAddressSpace
		extends IStringIdentifier,
				IType {
		
		/**
		*	The <code>baseUri</code> for this address space.
		*/
		function set baseUri( val:String ):void;
		function get baseUri():String;
		
		/**
		*	The <code>relativeUri</code> for this address space.
		*/
		function set relativeUri( val:String ):void;
		function get relativeUri():String;
		
		/**
		*	The full <code>uri</code> for this address space.
		*/		
		function get uri():String;
	}
}