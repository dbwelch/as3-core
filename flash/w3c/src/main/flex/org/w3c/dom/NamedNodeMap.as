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
		*	Retrieves a node specified by local name and namespace URI. 
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the node to retrieve.
		* 	@param localName The local name of the node to retrieve.
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be raised
		* 	if the implementation does not support the feature "XML"
		* 	and the language exposed through the Document does not support
		* 	XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return A Node (of any type) with the specified
		* 	local name and namespace URI, or null if they
		* 	do not identify any node in this map.
		*/
		function getNamedItemNS(
			namespaceURI:String, localName:String ):Node;
		
		/**
		* 	Adds a node using its namespaceURI and localName.
		* 	
		* 	If a node with that namespace URI and that local
		* 	name is already present in this map, it is replaced
		* 	by the new one. Replacing a node by itself has no effect.
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 
		* 	@param arg A node to store in this map.
		* 	The node will later be accessible using
		* 	the value of its namespaceURI and
		* 	localName attributes.
		* 
		* 	@throws DOMException WRONG_DOCUMENT_ERR: Raised if
		* 	arg was created from a different document than
		* 	the one that created this map. 
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this map is readonly. 
		* 
		* 	@throws DOMException INUSE_ATTRIBUTE_ERR: Raised if
		* 	arg is an Attr that is already an attribute of
		* 	another Element object. The DOM user must explicitly
		* 	clone Attr nodes to re-use them in other elements.
		* 
		* 	@throws DOMException HIERARCHY_REQUEST_ERR: Raised if
		* 	an attempt is made to add a node doesn't belong
		* 	in this NamedNodeMap. Examples would include
		* 	trying to insert something other than an Attr node
		* 	into an Element's map of attributes, or a non-Entity
		* 	node into the DocumentType's map of Entities. 
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be
		* 	raised if the implementation does not support
		* 	the feature "XML" and the language exposed
		* 	through the Document does not support XML
		* 	Namespaces (such as [HTML 4.01]).
		* 	
		* 	@return If the new Node replaces an existing
		* 	node the replaced Node is returned, otherwise
		* 	null is returned.
		*/
		function setNamedItemNS( arg:Node ):Node;
		
		/**
		* 	Removes a node specified by local name and
		* 	namespace URI. A removed attribute may
		* 	be known to have a default value when
		* 	this map contains the attributes attached
		* 	to an element, as returned by the attributes
		* 	attribute of the Node interface. If so,
		* 	an attribute immediately appears containing
		* 	the default value as well as the corresponding
		* 	namespace URI, local name, and prefix when applicable.
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the node to remove.
		* 	@param localName The local name of the node to remove.
		* 
		* 	@throws DOMException NOT_FOUND_ERR: Raised if
		* 	there is no node with the specified
		* 	namespaceURI and localName in this map.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this map is readonly. 
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be raised
		* 	if the implementation does not support the feature "XML"
		* 	and the language exposed through the Document does not
		* 	support XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return The node removed from this map
		* 	if a node with such a local name and
		* 	namespace URI exists.
		*/
		function removeNamedItemNS(
		 	namespaceURI:String, localName:String ):Node;
	}
}