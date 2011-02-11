package org.w3c.dom
{
	/**
	* 	Represents a location.
	* 	
	* 	DOMLocator is an interface that describes
	* 	a location (e.g. where an error occurred).
	*/
	public interface DOMLocator
	{
		/**
		* 	The line number this locator is pointing to,
		* 	or -1 if there is no line number available.
		*/
		function get lineNumber():Number;
		
		/**
		* 	The column number this locator is pointing to,
		* 	or -1 if there is no column number available.
		*/
		function get columnNumber():Number;
		
		/**
		* 	The byte offset into the input source this
		* 	locator is pointing to or -1 if there
		* 	is no byte offset available.
		*/
		function get byteOffset():Number;
		
		/**
		* 	The UTF-16, as defined in [Unicode] and
		* 	Amendment 1 of [ISO/IEC 10646], offset into
		* 	the input source this locator is pointing
		* 	to or -1 if there is no UTF-16 offset available.
		*/
		function get utf16Offset():Number;
		
		/**
		* 	The node this locator is pointing to, or
		* 	null if no node is available.
		*/
		function get relatedNode():Node;
		
		/**
		* 	The URI this locator is pointing to,
		* 	or null if no URI is available.
		*/
		function get uri():String;
	}
}