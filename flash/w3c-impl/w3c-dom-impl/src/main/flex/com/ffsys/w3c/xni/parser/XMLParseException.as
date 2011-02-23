package com.ffsys.w3c.xni.parser
{
	import java.lang.Throwable;
	import com.ffsys.w3c.xni.XNIException;
	
	/**
	* 	An exception thrown when an XML parse error is
	* 	encountered.
	* 
	*	This exception is different from the standard
	*	XNI exception in that it stores the location
	* 	in the document (or its entities) where the
	* 	exception occurred.
	*/
	public class XMLParseException extends XNIException
	{
		/**
		* 	Creates an <code>XMLParseException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function XMLParseException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}	
	}
}