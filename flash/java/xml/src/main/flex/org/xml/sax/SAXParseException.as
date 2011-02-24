package org.xml.sax
{
	
	/**
	* 	Encapsulate an XML parse error or warning.
	* 
	* 	This exception may include information for
	* 	locating the error in the original XML document,
	* 	as if it came from a Locator object.
	* 
	* 	Note that although the application will receive a
	* 	SAXParseException as the argument to the handlers
	* 	in the ErrorHandler interface, the application is
	* 	not actually required to throw the exception; instead,
	* 	it can simply read the information in it and take
	* 	a different action.
	*/
	public class SAXParseException extends SAXException
	{
		
		/**
		* 	Creates a <code>SAXParseException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function SAXParseException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}	
	}
}