package org.flashx.assert {
	
	/**
	*	Describes the contract for instances that store
	*	the result of multiple assertions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public interface IAssertionResultStore {
		
		/**
		*	The total number of assertions performed.	
		*/
		function get total():int;
		
		/**
		*	The number of assertions that have passed.
		*/		
		function get totalPasses():int;
		
		/**
		*	The number of assertions that have failed.
		*/		
		function get totalFailures():int;
		
		/**
		*	An <code>Array</code> containing the
		*	assertions that have passed.	
		*/
		function get passes():Array;
		
		/**
		*	An <code>Array</code> containing the
		*	assertions that have failed.
		*/
		function get failures():Array;
	}
}