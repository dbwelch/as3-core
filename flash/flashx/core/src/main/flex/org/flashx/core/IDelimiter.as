package org.flashx.core {
	
	/**
	*	Describes the contract for instances that maintain
	*	a <code>delimiter</code> property.
	*	
	*	@see com.ffsys.utils.address.IAddressPath
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2007
	*/
	public interface IDelimiter {
		
		/**
		*	A <code>delimiter</code> associated with this instance.
		*/
		function set delimiter( val:String ):void;
		function get delimiter():String;
	}
	
}
