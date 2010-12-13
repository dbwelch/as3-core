package com.ffsys.di
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

