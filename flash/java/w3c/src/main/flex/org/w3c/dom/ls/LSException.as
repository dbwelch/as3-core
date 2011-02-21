package org.w3c.dom.ls
{
	import java.lang.RuntimeException;
	import java.lang.Throwable;

	public class LSException extends RuntimeException
	{
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