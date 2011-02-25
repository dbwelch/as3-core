package org.w3c.dom
{
	import java.lang.RuntimeException;
	import java.lang.Throwable;	
	
	/**
	* 	Represents a DOM exception.
	* 
	* 	<p>DOM operations only raise exceptions in 
	* 	"exceptional" circumstances, i.e., when
	* 	an operation is impossible to perform
	* 	(either for logical reasons, because data
	* 	is lost, or because the implementation has
	* 	become unstable). In general, DOM methods
	* 	return specific error values in ordinary
	* 	processing situations, such as out-of-bound
	* 	errors when using NodeList.</p>
	*
	*	<p>Implementations should raise other exceptions
	* 	under other circumstances. For example,
	* 	implementations should raise an implementation-dependent
	* 	exception if a null argument is passed when
	* 	null was not expected.</p>
	*
	*	<p>Some languages and object systems do not support
	* 	the concept of exceptions. For such systems, error
	* 	conditions may be indicated using native error reporting
	* 	mechanisms. For some bindings, for example, methods may
	* 	return error codes similar to those listed in the
	* 	corresponding method descriptions.</p>
	*/
	public class DOMException extends RuntimeException
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
		* 	A message for when an XML name is invalid.
		*/
		static public const INVALID_XML_NAME_MSG:String
			= "The XML name '%s' is invalid.";
			
		/**
		* 	A message for when a feature is not supported.
		*/
		static public const UNSUPPORTED_FEATURE_MODULE_MSG:String
			= "The feature '%s' is not supported.";	
			
		/**
		* 	A message for when an event interface is not supported.
		*/
		static public const UNSUPPORTED_EVENT_INTERFACE_MSG:String
			= "The event interface '%s' is not supported.";		
		
		/**
		* 	Creates an <code>DOMException</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		* 	@param replacements Values to replace within
		* 	the detail message.
		*/
		public function DOMException(
			message:String = null,
			cause:Throwable = null,
			id:int = 0,
			replacements:Array = null )
		{
			super( message, cause, id, replacements );
		}		
	}
}