package com.ffsys.utils.assert {
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Describes the contract for instances that
	*	represent the result of performing an assertion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public interface IAssertionResult
		extends IAssertionElement,
				IObjectInspector {
		
		/**
		*	The name of the method used to perform
		*	the assertion.	
		*/
		function set methodName( val:String ):void;
		function get methodName():String;
		
		/**
		*	The parameters passed to the method used
		*	to perform the assertion.	
		*/
		function set parameters( val:Array ):void;
		function get parameters():Array;
	}
}