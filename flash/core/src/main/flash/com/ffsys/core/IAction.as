package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that maintain
	*	an <code>action</code> property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IAction {
		
		/**
		*	An <code>action</code> associated with this instance.
		*/		
		function set action( val:String ):void;
		function get action():String;
	}	
}