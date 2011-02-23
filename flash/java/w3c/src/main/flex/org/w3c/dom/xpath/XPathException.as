package org.w3c.dom.xpath
{
	import java.lang.Throwable;
	import org.w3c.dom.DOMException;
	
	/**
	* 	An xpath exception.
	*/
	public class XPathException extends DOMException
	{
		/**
		* 	An exception thrown when an invalid expression
		* 	is encountered.
		*/
		public static const INVALID_EXPRESSION_ERR:int = 51;
		
		/**
		* 	An exception thrown when an invalid type is encountered.
		*/
		public static const TYPE_ERR:int = 52;
		
		/**
		* 	Creates a <code>XPathException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function XPathException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}