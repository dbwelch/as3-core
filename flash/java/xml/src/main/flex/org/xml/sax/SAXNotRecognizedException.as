package org.xml.sax
{
	import java.lang.Throwable;	
	
	/**
	* 	Exception class for an unrecognized identifier.
	* 	
	* 	An XMLReader will throw this exception when it
	* 	finds an unrecognized feature or property identifier;
	* 	SAX applications and extensions may use this class for
	* 	other, similar purposes.
	*/
	public class SAXNotRecognizedException extends SAXException
	{
		
		/**
		* 	Creates a <code>SAXNotRecognizedException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function SAXNotRecognizedException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}	
	}
}