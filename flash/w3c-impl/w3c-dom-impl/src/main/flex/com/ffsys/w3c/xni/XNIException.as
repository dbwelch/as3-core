package com.ffsys.w3c.xni
{
	import java.lang.RuntimeException;
	import java.lang.Throwable;	
	
	/**
	* 	An XNI Exception.
	*/
	public class XNIException extends RuntimeException
	{
		/**
		* 	Creates an <code>XNIException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function XNIException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}