package com.ffsys.dom.core
{
	import com.ffsys.errors.AbstractError;
	
	import org.w3c.dom.*;	

	public class DOMExceptionImpl extends AbstractError
		implements DOMException
	{
		
		/**
		* 	If index or size is negative, or greater than the allowed value.
		*/
		static public const INDEX_SIZE_ERR:uint = 1;
		
		/**
		* 	If the specified range of text does not fit into a DOMString.
		*/
		static public const DOMSTRING_SIZE_ERR:uint = 2;
		
		/**
		* 	If any Node is inserted somewhere it doesn't belong.
		*/
		static public const HIERARCHY_REQUEST_ERR:uint = 3;
		
		/**
		* 	If a Node is used in a different document than
		* 	the one that created it (that doesn't support it).
		*/
		static public const WRONG_DOCUMENT_ERR:uint = 4;
		
		/**
		* 	If an invalid or illegal character is specified,
		* 	such as in an XML name.
		*/
		static public const INVALID_CHARACTER_ERR:uint = 5;
		
		/**
		* 	If data is specified for a Node which
		* 	does not support data.
		*/
		static public const NO_DATA_ALLOWED_ERR:uint = 6;
		
		/**
		* 	If an attempt is made to modify an object
		* 	where modifications are not allowed.
		*/
		static public const	NO_MODIFICATION_ALLOWED_ERR:uint = 7;
		
		/**
		* 	If an attempt is made to reference a Node in a
		* 	context where it does not exist.
		*/
		static public const	NOT_FOUND_ERR:uint = 8;
		
		/**
		* 	If the implementation does not support the
		* 	requested type of object or operation.
		*/
		static public const	NOT_SUPPORTED_ERR:uint = 9;
		
		/**
		* 	If an attempt is made to add an attribute
		* 	that is already in use elsewhere.
		*/
		static public const	INUSE_ATTRIBUTE_ERR:uint = 10;
		
		/**
		* 	If an attempt is made to use an object that is not,
		* 	or is no longer, usable.
		*/
		static public const	INVALID_STATE_ERR:uint = 11;
		
		/**
		* 	If an invalid or illegal string is specified.
		*/
		static public const	SYNTAX_ERR:uint = 12;
		
		/**
		* 	If an attempt is made to modify the type
		* 	of the underlying object.
		*/
		static public const	INVALID_MODIFICATION_ERR:uint = 13;
		
		/**
		* 	If an attempt is made to create or change an object
		* 	in a way which is incorrect with regard to namespaces.
		*/
		static public const	NAMESPACE_ERR:uint = 14;
		
		/**
		* 	If a parameter or an operation is not supported
		* 	by the underlying object.
		*/
		static public const	INVALID_ACCESS_ERR:uint = 15;
		
		/**
		* 	If a call to a method such as insertBefore or
		* 	removeChild would make the Node invalid with
		* 	respect to "partial validity", this exception
		* 	would be raised and the operation would not be done.
		* 	This code is used in [DOM Level 3 Validation].
		* 	Refer to this specification for further information.
		*/
		static public const	VALIDATION_ERR:uint = 16;
		
		/**
		* 	If the type of an object is incompatible with the
		* 	expected type of the parameter associated to the object.
		*/
		static public const	TYPE_MISMATCH_ERR:uint = 17;
		
		/**
		* 	Creates a <code>DOMExceptionImpl</code> instance.
		* 
		* 	@param code The exception code.
		* 	@param message The exception message.
		* 	@param substitutions Optional substitutions
		* 	for the error message.
		*/
		public function DOMExceptionImpl(
			code:uint = 0,
			message:String = "",
			substitutions:Array = null )
		{
			super( message, substitutions, code );
		}
	}
}