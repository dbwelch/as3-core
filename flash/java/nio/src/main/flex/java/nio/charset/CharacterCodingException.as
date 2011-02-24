package java.nio.charset
{
	import java.lang.Throwable;
	import java.io.IOException;
	
	/**
	* 	Encapsulates a character encoding exception.
	*/	
	public class CharacterCodingException extends IOException
	{
		/**
		* 	Creates a <code>CharacterCodingException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function CharacterCodingException(	
			message:String = null,
			cause:Throwable = null,
			id:int = -1,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}