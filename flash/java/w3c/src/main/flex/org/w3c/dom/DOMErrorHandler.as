package org.w3c.dom
{
	/**
	* 	!DOMErrorHandler is a callback interface that
	* 	the DOM implementation can call when reporting
	* 	errors.
	* 
	* 	<p>Errors may happen while processing XML data,
	* 	or when doing some other processing (e.g. validating a document).</p>
	* 
	* 	<p>A !DOMErrorHandler object can be attached to a
	* 	Document using the "error-handler" on the
	* 	DOMConfiguration interface. If more than one error
	* 	needs to be reported during an operation,
	* 	the sequence and numbers of the errors passed
	* 	to the error handler are implementation dependent.</p>
	*/
	public class DOMErrorHandler
	{
		/**
		* 	Represents an error handler method signature.
		* 
		* 	This method is called on the error handler when an error occurs. 
		* 
		*	If an exception is thrown from this method, it is considered
		* 	to be equivalent of returning true.
		* 
		* 	@param error The error object that describes the error. This object
		* 	may be reused by the DOM implementation across multiple
		* 	calls to the handleError method.
		* 
		* 	@return If the handleError method returns false, the DOM
		* 	implementation should stop the current processing when
		* 	possible. If the method returns true, the processing may
		* 	continue depending on DOMError.severity.
		*/
		public function handleError(
			error:DOMError ):Boolean
		{
			return false;
		}
	}
}