package org.w3c.dom
{
	/**
	* 	Represents a document configuration.
	* 
	* 	The DOMConfiguration interface represents
	* 	the configuration of a document and maintains
	* 	a table of recognized parameters. Using the
	* 	configuration, it is possible to change
	* 	Document.normalizeDocument() behavior,
	* 	such as replacing the CDATASection nodes
	* 	with Text nodes or specifying the type of
	* 	the schema that must be used when the validation
	* 	of the Document is requested. DOMConfiguration
	* 	objects are also used in [DOM Level 3 Load and Save]
	* 	in the DOMParser and DOMSerializer interfaces.
	*
	*	The parameter names used by the DOMConfiguration
	* 	object are defined throughout the DOM Level 3
	* 	specifications. Names are case-insensitive. To
	* 	avoid possible conflicts, as a convention, names
	* 	referring to parameters defined outside the DOM
	* 	specification should be made unique. Because
	* 	parameters are exposed as properties in names are
	* 	recommended to follow the section 5.16 Identifiers
	* 	of [Unicode] with the addition of the character '-'
	* 	(HYPHEN-MINUS) but it is not enforced by the DOM
	* 	implementation. DOM Level 3 Core Implementations
	* 	are required to recognize all parameters defined
	* 	in this specification. Some parameter values may
	* 	also be required to be supported by the implementation.
	* 	Refer to the definition of the parameter to know
	* 	if a value must be supported or not.
	*
	*	Note: Parameters are similar to features and properties
	* 	used in SAX2 [SAX].
	*
	*	The following list of parameters defined in the DOM:
	* 
	* 	TODO
	*/
	public interface DOMConfiguration
	{
		/**
		* 	The list of the parameters supported by
		* 	this DOMConfiguration object and for which
		* 	at least one value can be set by the application.
		* 	
		* 	Note that this list can also contain parameter
		* 	names defined outside this specification.
		*/
		function get parameterNames():DOMStringList;
		
		/**
		* 	Set the value of a parameter.
		* 
		* 	@param name The name of the parameter to set.
		* 	@param value The new value or null if the user
		* 	wishes to unset the parameter. While the type
		* 	of the value parameter is defined as DOMUserData,
		* 	the object type must match the type defined by
		* 	the definition of the parameter. For example
		* 	if the parameter is "error-handler",
		* 	the value must be of type DOMErrorHandler.
		* 
		* 	@throws DOMException - NOT_FOUND_ERR: Raised
		* 	when the parameter name is not recognized. 
		*	@throws NOT_SUPPORTED_ERR: Raised when the
		* 	parameter name is recognized but the requested
		* 	value cannot be set. 
		*	@throws TYPE_MISMATCH_ERR: Raised if the value type
		* 	for this parameter name is incompatible with
		* 	the expected value type.
		*/
		function setParameter( name:String, value:* ):void;
		
		/**
		* 	Return the value of a parameter if known.
		* 
		* 	@param name The name of the parameter.
		* 
		* 	@throws DOMException NOT_FOUND_ERR: Raised when
		* 	the parameter name is not recognized.
		* 
		* 	@return The current object associated
		* 	with the specified parameter or null
		* 	if no object has been associated or
		* 	if the parameter is not supported.
		*/
		function getParameter( name:String ):*;
		
		/**
		* 	Check if setting a parameter to a
		* 	specific value is supported.
		* 
		* 	@param name The name of the parameter to check.
		* 	@param value An object, if null, the returned value is true.
		* 
		* 	@return true if the parameter could be successfully
		* 	set to the specified value, or false if the parameter
		* 	is not recognized or the requested value is not supported.
		* 	This does not change the current value of the parameter itself.
		*/
		function canSetParameter( name:String, value:* ):Boolean;
	}
}