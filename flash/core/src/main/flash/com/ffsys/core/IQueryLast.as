package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that
	*	expose a method indicating whether the
	*	instance is the last part in a hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IQueryLast {
		
		/**
		*	Determines whether this is the last
		*	item in a hierarchy.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	this is the last part of a hierarchy.
		*/
		function isLast():Boolean;
	}
}