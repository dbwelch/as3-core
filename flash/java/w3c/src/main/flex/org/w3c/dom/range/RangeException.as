package org.w3c.dom.range
{
	
	import java.lang.Throwable;
	import org.w3c.dom.DOMException;	
	
	/**
	* 	Represents a DOM range exception.
	*/
	public class RangeException extends DOMException
	{
		
		/**
		* 	Indicates a bad boundary exception.
		*/
		public static const BAD_BOUNDARYPOINTS_ERR:int = 1;
		
		/**
		* 	Indicates an invalid node type exception.
		*/
		public static const INVALID_NODE_TYPE_ERR:int = 2;
		
		/**
		* 	Creates a <code>RangeException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function RangeException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}
	}
}