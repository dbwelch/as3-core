package org.w3c.dom.validation
{
	import java.lang.Throwable;
	import org.w3c.dom.DOMException;
	
	/**
	* 	Represents a DOM validation exception.
	*/
	public class DOMValidationException extends DOMException
	{
		/**
		* 	Indicates no schema is available to validate
		* 	against.
		*/
		public static const NO_SCHEMA_AVAILABLE_ERR:int = 71;
		
		/**
		* 	Creates a <code>DOMValidationException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function DOMValidationException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}