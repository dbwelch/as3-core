package org.w3c.dom
{
	/**
	* 	Represents an exception.
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
	public interface DOMException
	{
		/**
		* 	The code for this exception.
		*/
		function get code():uint;
		function set code( value:uint ):void;
	}
}

/*

DOMSTRING_SIZE_ERR
If the specified range of text does not fit into a DOMString.
HIERARCHY_REQUEST_ERR
If any Node is inserted somewhere it doesn't belong.
INDEX_SIZE_ERR
If index or size is negative, or greater than the allowed value.
INUSE_ATTRIBUTE_ERR
If an attempt is made to add an attribute that is already in use elsewhere.
INVALID_ACCESS_ERR, introduced in DOM Level 2.
If a parameter or an operation is not supported by the underlying object.
INVALID_CHARACTER_ERR
If an invalid or illegal character is specified, such as in an XML name.
INVALID_MODIFICATION_ERR, introduced in DOM Level 2.
If an attempt is made to modify the type of the underlying object.
INVALID_STATE_ERR, introduced in DOM Level 2.
If an attempt is made to use an object that is not, or is no longer, usable.
NAMESPACE_ERR, introduced in DOM Level 2.
If an attempt is made to create or change an object in a way which is incorrect with regard to namespaces.
NOT_FOUND_ERR
If an attempt is made to reference a Node in a context where it does not exist.
NOT_SUPPORTED_ERR
If the implementation does not support the requested type of object or operation.
NO_DATA_ALLOWED_ERR
If data is specified for a Node which does not support data.
NO_MODIFICATION_ALLOWED_ERR
If an attempt is made to modify an object where modifications are not allowed.
SYNTAX_ERR, introduced in DOM Level 2.
If an invalid or illegal string is specified.
TYPE_MISMATCH_ERR, introduced in DOM Level 3.
If the type of an object is incompatible with the expected type of the parameter associated to the object.
VALIDATION_ERR, introduced in DOM Level 3.
If a call to a method such as insertBefore or removeChild would make the Node invalid with respect to "partial validity", this exception would be raised and the operation would not be done. This code is used in [DOM Level 3 Validation]. Refer to this specification for further information.
WRONG_DOCUMENT_ERR
If a Node is used in a different document than the one that created it (that doesn't support it).		

*/
