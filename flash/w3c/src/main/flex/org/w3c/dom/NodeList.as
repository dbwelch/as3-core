package org.w3c.dom
{
	/**
	* 	Represents a sequential collection of nodes.
	*/
	public interface NodeList
	{
		/**
		*	The number of nodes in this list.
		*/
		function get length():uint;
		
		/**
		* 	Gets a node at the specified index.
		*/
		function item( index:uint ):Node;
	}
}