package java.io
{
	import java.lang.Throwable;		
	import java.lang.Exception;	
	
	/**
	* 	Encapsulates an input or output exception.
	*/
	public class IOException extends Exception
	{
		/**
		* 	Creates an <code>IOException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function IOException(
			message:String = null,
			cause:Throwable = null,
			id:int = -1,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}