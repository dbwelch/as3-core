package org.w3c.dom.ls
{
	import org.w3c.dom.Document;
	import org.w3c.dom.events.DOMEvent;
	
	/**
	* 	This interface represents a load event object
	* 	that signals the completion of a document load.
	*/
	public interface LSLoadEvent extends DOMEvent
	{
		/**
		* 	The document that finished loading.
		*/
		function getNewDocument():Document;
		
		/**
		* 	The input source that was parsed.
		*/
		function getInput():LSInput;
	}
}