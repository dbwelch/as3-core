package org.w3c.dom
{
	/**
	* 	Represents a named node map.
	* 
	* 	<p>Objects implementing the NamedNodeMap interface
	* 	are used to represent collections of nodes that
	* 	can be accessed by name. Note that NamedNodeMap
	* 	does not inherit from NodeList; NamedNodeMaps are
	* 	not maintained in any particular order.</p>
	* 
	* 	<p>Objects contained in an object implementing
	* 	NamedNodeMap may also be accessed by an ordinal
	* 	index, but this is simply to allow convenient
	* 	enumeration of the contents of a NamedNodeMap,
	* 	and does not imply that the DOM specifies
	* 	an order to these Nodes.</p>
	* 
	* 	<p>NamedNodeMap objects in the DOM are live.</p>
	*/
	public interface NamedNodeMap
	{
		
		/**
		*	The number of nodes in this map. The range of
		* 	valid child node indices is 0 to length-1 inclusive.
		*/
		function get length():uint;
		
		/**
		* 	Retrieves an item by local name.
		* 
		* 	@param name The local name of the node.
		* 
		* 	@return The retrieved node or <code>null</code>
		* 	if no matching node was found.
		*/
		function getNamedItem( name:String ):Node;
		
		/**
		* 	Sets a node on this map.
		* 
		* 	If no node with the same name exists
		* 	the specified node is added.
		* 
		* 	If a node exists with the same
		* 	name the existing node is removed before
		* 	the specified node is added.
		* 
		* 	@param item The node to set on this map.
		*/
		function setNamedItem( item:Node ):Node;
		
		/**
		* 	Removes a named node from this map.
		* 
		* 	@param name The name of the node.
		* 
		* 	@return The node that was removed or <code>null</code>
		* 	if no matching node was found.
		*/
		function removeNamedItem( name:String ):Node;
		
		/**
		* 	Returns the indexth item in the map.
		* 	
		* 	If index is greater than or equal to
		* 	the number of nodes in this map, this returns null.
		* 
		* 	@param index Index into this map.
		* 
		* 	@return The node at the indexth position in the
		* 	map, or null if that is not a valid index.
		*/
		function item( index:uint ):Node;
		
		/**
		*	TODO
		*/
		function getNamedItemNS(
			namespaceURI:String, localName:String ):Node;
		
		/**
		* 	TODO
		*/
		function setNamedItemNS( arg:Node ):Node;
		
		/**
		* 	TODO
		*/
		function removeNamedItemNS(
		 	namespaceURI:String, localName:String ):Node;
	}
}