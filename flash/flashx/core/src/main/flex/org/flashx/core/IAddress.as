package org.flashx.core {
	
	/**
	*	Describes the contract for instances that maintain
	*	an <code>address</code> property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.12.2007
	*/
	public interface IAddress {
		
		/**
		*	An <code>address</code> associated with this instance.
		*/		
		function set address( val:String ):void;
		function get address():String;
	}
}