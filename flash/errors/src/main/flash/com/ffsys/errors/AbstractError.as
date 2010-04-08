package com.ffsys.errors {

	import com.ffsys.utils.string.StringSubstitutor;
	
	/**
	*	Super class for all custom
	*	<code>Error</code> instances.
	*	
	*	Allows for substitution of <code>%s</code> instances
	*	within the error message <code>String</code> to be
	*	replaced with relevant information pertaining to
	*	the error encountered.
	*	
	*	@see com.ffsys.utils.string.StringSubstitutor
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2007
	*/
	public class AbstractError extends Error {
	
		/**
		*	Creates an <code>AbstractError</code>
		*	instance.
		*	
		*	@param message The <code>Error</code> message.
		*	@param substitutions The <code>message</code>
		*	substitution values.
		*/
		public function AbstractError(
			message:String = "",
			substitutions:Array = null )
		{	
			var substitutor:StringSubstitutor = 
				new StringSubstitutor();
			message = substitutor.replace( message, substitutions );
			super( message, 0 );
		}
	}
}