package java.lang
{
	/**
	* 	Thrown to indicate that the requested operation is not supported.
	*/
	public class UnsupportedOperationException extends RuntimeException
	{
		
		/**
		* 	A default exception message.
		*/
		public static const MESSAGE:String = "The operation is not supported.";
		
		/**
		* 	Creates an <code>UnsupportedOperationException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function UnsupportedOperationException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			if( message == null )
			{
				message = MESSAGE;
			}
			super( message, cause, id, replacements );
		}
	}
}