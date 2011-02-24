package org.xml.sax
{
	import java.lang.Throwable;
	
	/**
	*	Exception class for an unsupported operation.
	* 
	* 	An XMLReader will throw this exception when
	* 	it recognizes a feature or property identifier,
	* 	but cannot perform the requested operation
	* 	(setting a state or value). Other SAX2 applications
	* 	and extensions may use this class for similar purposes.
	*/
	public class SAXNotSupportedException extends SAXException
	{
		
		/**
		* 	Creates a <code>SAXNotSupportedException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function SAXNotSupportedException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}	
	}
}