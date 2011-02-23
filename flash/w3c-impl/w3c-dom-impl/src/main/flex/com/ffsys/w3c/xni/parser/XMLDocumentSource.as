package com.ffsys.w3c.xni.parser
{
	import com.ffsys.w3c.xni.XMLDocumentHandler;	
	
	/**
	*	Defines a document source.
	* 	
	* 	In other words, any object that implements this
	* 	interface is able to emit document "events"
	* 	to the registered document handler.
	* 
	* 	These events could be produced by parsing an XML document,
	*	could be generated from some other source, or could be
	* 	created programmatically.
	* 	
	* 	This interface does not say <em>how</em> the events are
	*	created, only that the implementor is able to emit them.
	*/
	public interface XMLDocumentSource
	{
		
		/*
		
	    //
	    // XMLDocumentSource methods
	    //

	    /// Sets the document handler.
	    //public void setDocumentHandler(XMLDocumentHandler handler);

	    // Returns the document handler
	    //public XMLDocumentHandler getDocumentHandler();		
		
		*/
	}
}