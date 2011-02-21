package java.lang
{
	public class Exception extends Throwable
	{
		
		/**
		* 	Creates an <code>Exception</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		*/
		public function Exception(
			message:String = null,
			cause:Throwable = null,
			id:int = 0 )
		{
			super( message, cause, id );
		}
	}
}