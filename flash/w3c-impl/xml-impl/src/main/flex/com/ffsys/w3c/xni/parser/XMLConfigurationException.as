package com.ffsys.w3c.xni.parser
{
	import java.lang.Throwable;
		
	import com.ffsys.w3c.xni.XNIException;
	
	/**
	* 	An XML configuration exception.
	*/
	public class XMLConfigurationException extends XNIException
	{
	    /**
		*	Identifier not recognized.
		*/
	    public static const NOT_RECOGNIZED:uint = 0;

	    /**
		*	Identifier not supported.
		*/
	    public static const NOT_SUPPORTED:uint = 1;
		
		/**
		* 	Creates an <code>XMLConfigurationException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function XMLConfigurationException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )		
		{
			super( message, cause, id, replacements );
		}	
	}
}