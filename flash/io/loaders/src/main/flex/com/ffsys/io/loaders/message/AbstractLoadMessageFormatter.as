/**
*	Contains classes used to associate text messages with load operations.
*/
package com.ffsys.io.loaders.message {
	
	/**
	*	Default <code>ILoadMessageFormatter</code>
	*	implementation, simply passes the source
	*	<code>message</code> through untouched.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.09.2007
	*/
	public class AbstractLoadMessageFormatter extends Object
		implements ILoadMessageFormatter {
		
		/**
		*	Creates an <code>AbstractLoadMessageFormatter</code>
		*	instance.
		*/
		public function AbstractLoadMessageFormatter()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		public function format(
			message:String = null,
			id:String = null ):String
		{
			return message;
		}
	}
}