package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that expose
	*	a <code>type</code> identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2007
	*/
	public interface IType {
		
		/**
		*	The <code>type</code> of the instance.
		*/
		function set type( val:String ):void;
		function get type():String;
	}
}