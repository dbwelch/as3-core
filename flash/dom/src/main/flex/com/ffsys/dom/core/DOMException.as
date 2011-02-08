package com.ffsys.dom.core
{
	import com.ffsys.errors.AbstractError;

	public class DomException extends AbstractError
	{
		
		static public const INDEX_SIZE_ERR:uint = 1;
		
		static public const DOMSTRING_SIZE_ERR:uint = 2;
		
		static public const HIERARCHY_REQUEST_ERR:uint = 3;
		
		static public const WRONG_DOCUMENT_ERR:uint = 4;
		
		static public const INVALID_CHARACTER_ERR:uint = 5;
		
		static public const NO_DATA_ALLOWED_ERR:uint = 6;
		
		static public const	NO_MODIFICATION_ALLOWED_ERR:uint = 7;
		
		static public const	NOT_FOUND_ERR:uint = 8;
		
		static public const	NOT_SUPPORTED_ERR:uint = 9;
		
		static public const	INUSE_ATTRIBUTE_ERR:uint = 10;
		
		// Introduced in DOM Level 2:
		static public const	INVALID_STATE_ERR:uint = 11;
		
		// Introduced in DOM Level 2:
		static public const	SYNTAX_ERR:uint = 12;
		
		// Introduced in DOM Level 2:
		static public const	INVALID_MODIFICATION_ERR:uint = 13;
		
		// Introduced in DOM Level 2:
		static public const	NAMESPACE_ERR:uint = 14;
		
		// Introduced in DOM Level 2:
		static public const	INVALID_ACCESS_ERR:uint = 15;
		
		// Introduced in DOM Level 3:
		static public const	VALIDATION_ERR:uint = 16;
		
		// Introduced in DOM Level 3:
		static public const	TYPE_MISMATCH_ERR:uint = 17;
		
		/**
		* 	Creates a <code>DomException</code> instance.
		* 
		* 	@param code The exception code.
		* 	@param message The exception message.
		* 	@param substitutions Optional substitutions
		* 	for the error message.
		*/
		public function DomException(
			code:uint = 0,
			message:String = "",
			substitutions:Array = null )
		{
			super( message, substitutions, code );
		}
	}
}