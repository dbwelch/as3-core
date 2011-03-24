package org.flashx.utils.assert {
	
	/**
	*	Represents a pass for an individual assertion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public class AssertionPass extends AssertionResult
		implements IAssertionPass {
		
		/**
		*	Creates an <code>AssertionPass</code> instance.
		*	
		*	@param methodName The assertion method name that was
		*	invoked to perform the assertion.
		*	@param parameters The parameters passed to the method
		*	that was invoked to perform the assertion.
		*/
		public function AssertionPass(
			methodName:String = "",
			parameters:Array = null )		
		{
			super( methodName, parameters );
		}
	}
}