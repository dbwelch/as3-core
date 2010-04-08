package com.ffsys.utils.reflection.members {
	
	/**
	*	Describes the contract for instance that represent methods.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public interface IMethod {
		
		/**
		*	Determines whether the method has any required parameters.
		*/
		function hasRequiredParameters():Boolean;
	}
	
}
