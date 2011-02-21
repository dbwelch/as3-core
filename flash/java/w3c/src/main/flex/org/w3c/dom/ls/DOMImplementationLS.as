package org.w3c.dom.ls
{
	
	/**
	* 	DOMImplementationLS contains the factory methods
	* 	for creating Load and Save objects.
	* 
	* 	The expectation is that an instance of the
	* 	DOMImplementationLS interface can be obtained by
	* 	using binding-specific casting methods on an instance
	* 	of the DOMImplementation interface or, if the Document
	* 	supports the feature "Core" version "3.0" defined in
	* 	[DOM Level 3 Core] , by using the method DOMImplementation.getFeature
	* 	with parameter values "LS" (or "LS-Async") and "3.0" (respectively).
	* 
	* 	See also the Document Object Model (DOM) Level 3 Load and Save Specification.
	*/
	public interface DOMImplementationLS
	{
		/**
		* 	Create a new empty input source object
		* 	where LSInput.characterStream, LSInput.byteStream,
		* 	LSInput.stringData LSInput.systemId,
		* 	LSInput.publicId, LSInput.baseURI, and
		* 	LSInput.encoding are null, and
		* 	LSInput.certifiedText is false.
		* 
		* 	@return The newly created input object.
		*/
		function createLSInput():LSInput;
		
		/**
		* 	Create a new empty output destination object
		* 	where LSOutput.characterStream, LSOutput.byteStream,
		* 	LSOutput.systemId, LSOutput.encoding are null.
		* 
		* 	@return The newly created output object.
		*/
		function createLSOutput():LSOutput;
		
		/**
		* 	Create a new LSSerializer object.
		* 
		* 	@return The newly created LSSerializer object.
		* 
		* 	<p><strong>Note:</strong> By default, the newly created LSSerializer
		* 	has no DOMErrorHandler, i.e. the value of the "error-handler"
		* 	configuration parameter is null. However, implementations
		* 	may provide a default error handler at creation time.
		* 	In that case, the initial value of the "error-handler"
		* 	configuration parameter on the new LSSerializer object
		* 	contains a reference to the default error handler.</p>
		*/
		function createLSSerializer():LSSerializer;
		
		/**
		* 	Create a new LSParser.
		* 	
		* 	The newly constructed parser may then be configured
		* 	by means of its DOMConfiguration object, and used to
		* 	parse documents by means of its parse method.
		* 
		* 	@param mode The mode argument is either
		* 	MODE_SYNCHRONOUS or MODE_ASYNCHRONOUS, if mode
		* 	is MODE_SYNCHRONOUS then the LSParser that
		* 	is created will operate in synchronous mode,
		* 	if it's MODE_ASYNCHRONOUS then the LSParser that
		* 	is created will operate in asynchronous mode.
		* 	@param schemaType An absolute URI representing the
		* 	type of the schema language used during the load
		* 	of a Document using the newly created LSParser.
		* 	Note that no lexical checking is done on the absolute URI.
		* 	In order to create a LSParser for any kind of schema types
		* 	(i.e. the LSParser will be free to use any schema found),
		* 	use the value null.
		* 
		* 	<p>Note: By default, the newly created LSParser does
		* 	not contain a DOMErrorHandler, i.e. the value of the
		* 	"error-handler" configuration parameter is null. However,
		* 	implementations may provide a default error handler at
		* 	creation time. In that case, the initial value of the
		* 	"error-handler" configuration parameter on the new
		* 	LSParser object contains a reference to the default error handler.</p>
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: Raised if the requested mode
		* 	or schema type is not supported.
		* 
		* 	@return The newly created LSParser object. This LSParser
		* 	is either synchronous or asynchronous depending on the value
		* 	of the mode argument.
		*/
		function createLSParser(
			mode:int, schemaType:String = null ):LSParser;
	}
}