package java.lang
{
	
	/**
	*	RuntimeException is the superclass of those exceptions that
	* 	can be thrown during the normal operation of the Java Virtual Machine.
	*
	*	A method is not required to declare in its throws clause any subclasses
	* 	of RuntimeException that might be thrown during the execution of the
	* 	method but not caught.
	*/
	public class RuntimeException extends Exception
	{
		/**
		* 	Creates a <code>RuntimeException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function RuntimeException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}