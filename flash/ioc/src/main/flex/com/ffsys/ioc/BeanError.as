package com.ffsys.ioc
{
	import com.ffsys.errors.AbstractError;
	
	/**
	*	Encapsulates errors thrown related to the bean
	* 	dependency injection functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class BeanError extends AbstractError
	{
		/**
		* 	Error thrown when a bean expression failed to resolve.
		*/
		public static const BEAN_REFERENCE_ERROR:String = 
			"Could not resolve expression %s on bean %s, property name is '%s' and parsed expression data is '%s'.";
		
		/**
		* 	Creates a <code>BeanError</code> instance.
		* 
		* 	@param message The message for the error.
		* 	@param replacements Replacement valued for the message.
		*/
		public function BeanError( message:String, ... replacements )
		{
			super( message, replacements );
		}
	}
}

