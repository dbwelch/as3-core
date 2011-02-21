package org.w3c.dom.ls
{
	import java.lang.RuntimeException;
	import java.lang.Throwable;
	
	/**
	* 	Parser or write operations may throw an LSException
	* 	if the processing is stopped.
	* 
	* 	The processing can be stopped due to a DOMError with a
	* 	severity of DOMError.SEVERITY_FATAL_ERROR or a non recovered
	* 	DOMError.SEVERITY_ERROR, or if DOMErrorHandler.handleError() returned false.
	* 
	* 	<strong>Note:</strong> As suggested in the definition of the constants in the
	* 	DOMError interface, a DOM implementation may choose to continue
	* 	after a fatal error, but the resulting DOM tree is then
	* 	implementation dependent.
	*/
	public class LSException extends RuntimeException
	{
		/**
		* 	If an attempt was made to load a document,
		* 	or an XML Fragment, using LSParser and the processing
		* 	has been stopped.
		*/
		public static const PARSE_ERR:int = 81;
		
		/**
		* 	If an attempt was made to serialize a Node
		* 	using LSSerializer and the processing has been stopped.
		*/
		public static const SERIALIZE_ERR:int = 82;
		
		/**
		* 	Creates an <code>LSException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function LSException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}