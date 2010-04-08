package com.ffsys.utils.reflection {
	
	/**
	*	Describe the contract for instances that maintain
	*	a reference to their parent.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public interface IReflectionParent {
		function set parent( val:IReflection ):void;
		function get parent():IReflection;		
	}
	
}
