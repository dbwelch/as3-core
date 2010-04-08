package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that provide
	*	an <code>enabled</code> flag indicating whether
	*	the instance is <code>enabled</code> or not.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.12.2007
	*/
	public interface IEnabled {
		
		/**
		*	Determines whether this instance is <code>enabled</code>.
		*/
		function set enabled( val:Boolean ):void;
		function get enabled():Boolean;
	}
	
}
