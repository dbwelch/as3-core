package org.w3c.dom.ls
{
	import org.w3c.dom.events.DOMEvent;
	
	/**
	* 	This interface represents a progress event object that
	* 	notifies the application about progress as a document is parsed.
	* 
	* 	It extends the DOMEvent interface defined in [DOM Level 3 Events].
	* 
	* 	The units used for the attributes position and totalSize are
	* 	not specified and can be implementation and input dependent.
	*/
	public interface LSProgressEvent extends DOMEvent
	{
		/**
		*	The input source that is being parsed.
		* 
		* 	@return The input source.
		*/
		function getInput():LSInput;
		
		/**
		* 	The current position in the input source,
		* 	including all external entities and other
		* 	resources that have been read.
		* 
		* 	@return The position.
		*/
		function getPosition():int;
		
		/**
		* 	The total size of the document including all
		* 	external resources, this number might change as a
		* 	document is being parsed if references to more external
		* 	resources are seen. A value of 0 is returned if the
		* 	total size cannot be determined or estimated.
		* 
		* 	@return The total size.
		*/
		function getTotalSize():int;
	}
}