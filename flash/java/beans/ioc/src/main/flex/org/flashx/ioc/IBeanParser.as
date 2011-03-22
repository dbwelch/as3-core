package org.flashx.ioc
{
	/**
	*	Describes the contract for implementations that parse
	* 	files describing the beans for a document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public interface IBeanParser
	{	
		/**
		* 	The bean document to parse into.
		*/
		function get document():IBeanDocument;
		function set document( value:IBeanDocument ):void;
		
		/**
		* 	Parses the <code>text</code> and returns the 
		* 	encapsulated document after parsing has taken place.
		* 
		* 	@param text The text for parsed.
		* 
		* 	@return A bean document.
		*/
		function parse( text:String ):IBeanDocument;
	}
}