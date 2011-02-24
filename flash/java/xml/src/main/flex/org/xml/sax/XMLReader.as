package org.xml.sax
{
	/**
	* 	Interface for reading an XML document using callbacks.
	* 
	* 	<p><strong>Note:</strong> despite its name, this interface does not
	* 	extend the standard Java Reader interface, because
	* 	reading XML is a fundamentally different activity
	* 	than reading character data.</p>
	* 
	* 	<p>XMLReader is the interface that an XML parser's
	* 	SAX2 driver must implement. This interface allows
	* 	an application to set and query features and properties
	* 	in the parser, to register event handlers for document
	* 	processing, and to initiate a document parse.</p>
	* 
	* 	<p>All SAX interfaces are assumed to be synchronous:
	* 	the parse methods must not return until parsing is
	* 	complete, and readers must wait for an event-handler
	* 	callback to return before reporting the next event.</p>
	*/
	public interface XMLReader
	{
		
	}
}