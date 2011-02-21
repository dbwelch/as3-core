package org.w3c.dom
{
	/**
	* 	Represents a list of string values.
	*/
	public interface DOMStringList
	{
		
		/**
		*	The number of items in this list.
		*/
		function get length():uint;
		
		/**
		* 	Retrieves a string from the list
		* 	at the specified index.
		*/
		function item( index:uint ):String;
		
		/**
		* 	Determines whether this list contains
		* 	the specified string.
		*/
		function contains( str:String ):Boolean;
	}
}