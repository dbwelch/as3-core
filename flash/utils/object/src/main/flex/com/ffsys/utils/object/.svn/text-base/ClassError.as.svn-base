package com.ffsys.utils.object {
	
	import com.ffsys.errors.AbstractError;
	
	/**
	*	<code>Error</code> thrown when a problem
	*	occurs during a reflection process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.06.2007
	*/
	public class ClassError extends AbstractError {
		
		static public const PRIVATE_CLASS:String =
			"Possible attempt to access a private class with getDefinitionByName()";
		
		/**
		*	Creates a <code>ClassError</code>
		*	instance.
		*	
		*	@param message The <code>Error</code> message.
		*	@param ...args The <code>message</code>
		*	substitution values.
		*/		
		public function ClassError(
			message:String = "", ...args )
		{
			super( message, args );
		}
	}
}