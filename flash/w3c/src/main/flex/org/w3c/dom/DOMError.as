package org.w3c.dom
{
	/**
	* 	Represents an error.
	* 
	* 	DOMError is an interface that describes an error.
	*/
	public interface DOMError
	{
		/**
		* 	The severity of the error,
		* 	either SEVERITY_WARNING,
		* 	SEVERITY_ERROR, or SEVERITY_FATAL_ERROR.
		*/
		function get severity():Number;
		
		/**
		* 	An implementation specific string
		* 	describing the error that occurred.
		*/
		function get message():String;
		
		/**
		* 	A DOMString indicating which related data is
		* 	expected in relatedData. Users should refer to
		* 	the specification of the error in order to find
		* 	its DOMString type and relatedData definitions if any.
		*
		* 	Note: As an example, Document.normalizeDocument()
		* 	does generate warnings when the "split-cdata-sections"
		* 	parameter is in use. Therefore, the method generates
		* 	a SEVERITY_WARNING with type "cdata-sections-splitted"
		* 	and the first CDATASection node in document order
		* 	resulting from the split is returned by the relatedData attribute.
		*/
		function get type():String;
		
		/**
		* 	The related platform dependent exception if any.
		*/
		function get relatedException():Object;
		
		/**
		* 	The related DOMError.type dependent data if any.
		*/
		function get relatedData():Object;
		
		/**
		* 	The location of the error.
		*/
		function get location():DOMLocator;
	}
	
	/*
	static short	SEVERITY_ERROR 
	          The severity of the error described by the DOMError is error.
	static short	SEVERITY_FATAL_ERROR 
	          The severity of the error described by the DOMError is fatal error.
	static short	SEVERITY_WARNING 
	          The severity of the error described by the DOMError is warning.	
	*/
}