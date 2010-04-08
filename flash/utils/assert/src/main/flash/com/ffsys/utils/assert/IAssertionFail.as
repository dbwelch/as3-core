package com.ffsys.utils.assert {
	
	/**
	*	Describes the contract for instances that represent
	*	an assertion failure.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public interface IAssertionFail extends IAssertionResult {
		
		/**
		*	An <code>AssertionError</code> instance
		*	associated with this failure.
		*/		
		function set error( val:AssertionError ):void;
		function get error():AssertionError;
	}	
}