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
			"Could not resolve expression '%s' on bean '%s', property name is '%s' and parsed expression data is '%s'.";
			
		/**
		* 	Error thrown if there was an exception encountered while
		* 	trying to invoke a method on a bean.
		*/
		public static const BEAN_METHOD_INVOCATION:String = 
			"Could not invoke method '%s' on bean '%s' with parameters '%s'.";
			
		/**
		* 	Error thrown if there was an exception encountered while
		* 	trying to set a property with the return value from invoking
		* 	a method on a bean.
		*/
		public static const BEAN_METHOD_RESULT_SET:String = 
			"Could not set method return value on property '%s' of bean '%s' with value '%s'.";

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

