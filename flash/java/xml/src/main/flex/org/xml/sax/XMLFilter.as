package org.xml.sax
{
	
	/**
	* 	Interface for an XML filter.
	* 
	* 	An XML filter is like an XML reader, except
	* 	that it obtains its events from another XML reader
	* 	rather than a primary source like an XML document
	* 	or database. Filters can modify a stream of events
	* 	as they pass on to the final application.
	* 
	* 	The XMLFilterImpl helper class provides a
	* 	convenient base for creating SAX2 filters,
	* 	by passing on all EntityResolver, DTDHandler,
	* 	ContentHandler and ErrorHandler events automatically.
	*/
	public interface XMLFilter extends XMLReader
	{
		
	}
}