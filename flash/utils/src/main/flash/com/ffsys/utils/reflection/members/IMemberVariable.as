package com.ffsys.utils.reflection.members {
	
	/**
	*	Describes the contract for members that are variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public interface IMemberVariable {
		
		/**
		*	Attempts to the get the value of the property
		*	on the target Object that created the Reflection.
		*/
		function get value():*;
	}
	
}
