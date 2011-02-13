package org.w3c.dom
{
	/**
	* 	Represents a list of nodes.
	* 
	* 	The NodeList interface provides the abstraction of
	* 	an ordered collection of nodes, without defining
	* 	or constraining how this collection is implemented.
	* 	NodeList objects in the DOM are live.
	*
	*	The items in the NodeList are accessible
	* 	via an integral index, starting from 0.
	*/
	public interface NodeList
	{
		/**
		*	The number of nodes in the list.
		* 	
		* 	The range of valid child node indices
		* 	is 0 to length-1 inclusive.
		*/
		function get length():uint;
		
		/**
		* 	Returns the indexth item in the collection.
		* 
		* 	If index is greater than or equal to the
		* 	number of nodes in the list, this returns null.
		* 
		* 	@param index Index into the collection.
		* 
		* 	@return The node at the indexth position
		* 	in the NodeList, or null if it is not a valid index.
		*/
		function item( index:uint ):Node;
	}
}