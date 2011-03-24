package org.flashx.utils.history {
	
	import org.flashx.errors.AbstractError;
	
	/**
	*	Errors thrown by <code>History</code> instances
	*	when they are operating in a <code>strict</code>
	*	manner.
	*	
	*	@see com.ffsys.errors.AbstractError
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.09.2007
	*/
	public class HistoryError extends AbstractError {
		
		/**
		*	Error thrown when an attempt is made to
		*	change the position of a <code>History</code>
		*/
		static public const INVALID_POSITION:String =
			"Invalid position, cannot set the position to '%s' with a length of '%s'";
		
		/**
		*	Error thrown when attempting to add a <code>null</code>
		*	value to a <code>History</code> instance.
		*/
		static public const NULL_VALUE:String =
			"Cannot add a null item to a history list";
			
		/**
		*	Error thrown when attempting to add a
		*	<code>History</code> item that already
		*	exists in the instance.
		*/
		static public const VALUE_EXISTS:String =
			"Cannot add duplicate value '%s'";			
		
		/**
		*	Creates a new <code>HistoryError</code>
		*	instance with the specified error
		*	<code>message</code> and substitution parameters.
		*	
		*	@param message The error <code>message</code>.
		*	@param ...args The values that form replacements within
		*	the error <code>message</code>.
		*/
		public function HistoryError(
			message:String = "", ...args )
		{
			super( message, args );
		}
	}
}