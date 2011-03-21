package org.flashx.io.xml {
	
	import org.flashx.errors.AbstractError;
	
	/**
	*	Error thrown when a problem is 
	*	encountered serializing to <code>XML</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.06.2007
	*/
	public class SerializeError extends AbstractError {
		
		/**
		*	Creates a <code>SerializeError</code>
		*	instance.
		*	
		*	@param message The <code>Error</code> message.
		*	@param ...args The <code>message</code>
		*	substitution values.
		*/
		public function SerializeError(
			message:String = "", ...args )
		{
			super( message, args );
		}
	}
}