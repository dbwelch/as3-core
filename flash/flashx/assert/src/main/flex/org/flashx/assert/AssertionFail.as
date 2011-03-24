package org.flashx.assert {
	
	/**
	*	Represents a failure for an individual assertion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public class AssertionFail extends AssertionResult
		implements IAssertionFail {
			
		/**
		*	@private	
		*/
		protected var _error:AssertionError;
		
		/**
		*	Creates an <code>AssertionFail</code> instance.
		*	
		*	@param methodName The assertion method name that was
		*	invoked to perform the assertion.
		*	@param parameters The parameters passed to the method
		*	that was invoked to perform the assertion.
		*/
		public function AssertionFail(
			methodName:String = "",
			parameters:Array = null )		
		{
			super( methodName, parameters );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set error( val:AssertionError ):void
		{
			_error = val;
		}
		
		public function get error():AssertionError
		{
			return _error;
		}
	}
}