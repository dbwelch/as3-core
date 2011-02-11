package org.w3c.dom
{
	/**
	* 	Represents an implementation list.
	* 
	* 	The DOMImplementationList interface
	* 	provides the abstraction of an ordered
	* 	collection of DOM implementations, without
	* 	defining or constraining how this collection
	* 	is implemented.
	* 
	* 	The items in the DOMImplementationList are
	* 	accessible via an integral index, starting
	* 	from 0.
	*/
	public interface DOMImplementationList
	{
		
		/**
		* 	The number of DOMImplementations in the list.
		* 
		* 	The range of valid child node indices is 0
		* 	to length-1 inclusive.
		*/
		function get length():uint;
		
		/**
		* 	Returns the indexth item in the collection.
		* 	
		* 	If index is greater than or equal to the
		* 	number of DOMImplementations in the list,
		* 	this returns null.
		* 
		* 	@param index  Index into the collection.
		* 
		* 	@return The DOMImplementation at the index
		* 	the position in the DOMImplementationList,
		* 	or null if that is not a valid index.
		*/
		function item( index:int ):DOMImplementation;
	}
}