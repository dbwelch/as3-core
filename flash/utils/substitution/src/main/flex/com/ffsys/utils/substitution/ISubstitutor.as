package com.ffsys.utils.substitution {
	
	/**
	*	Describes the contract that provide an API
	*	for looking up properties from a String substitution
	*	candidate in the form:
	*
	*	{object.property}
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.09.2007
	*/
	public interface ISubstitutor {
		
		function set strict( val:Boolean ):void;
		function get strict():Boolean;		
		
	}
	
}
