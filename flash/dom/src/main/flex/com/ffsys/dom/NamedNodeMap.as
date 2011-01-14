package com.ffsys.dom
{

	dynamic public class NamedNodeMap extends NodeList
	{
		/**
		* 	Creates a <code>NamedNodeMap</code> instance.
		*/
		public function NamedNodeMap()
		{
			super();
		}
		
		/**
		* 	Retrieves an item by local name.
		* 
		* 	@param name The local name of the node.
		* 
		* 	@return The retrieved node or <code>null</code>
		* 	if no matching node was found.
		*/
		public function getNamedItem( name:String ):Node
		{
			var node:Node = null;
			for each( node in this )
			{
				if( node.localName == name )
				{
					break;
				}
			}
			return node;
		}
		
		/**
		* 	Determines whether this map contains the specified
		* 	node.
		* 
		* 	@param item The node to test for existence.
		* 
		* 	@return A boolean indicating whether the node exists
		* 	in this map.
		*/
		public function hasNamedItem( item:Node ):Boolean
		{
			var node:Node = null;
			for each( node in this )
			{
				if( node == item )
				{
					return true;
				}
			}
			return false;
		}
		
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
		public function setNamedItem( item:Node ):Node
		{
			if( item != null && item.localName != null )
			{
				var existing:Node = getNamedItem( item.localName );
				if( existing == null )
				{
					concat( item );
				}else{
					removeNamedItem( existing.localName );
					concat( item );
				}
			}
			return item;
		}
		
		/**
		* 	Removes a named node from this map.
		* 
		* 	@param name The name of the node.
		* 
		* 	@return The node that was removed or <code>null</code>
		* 	if no matching node was found.
		*/
		public function removeNamedItem( name:String ):Node
		{
			if( name != null )
			{
				var child:Node = null;
				for( var i:int = 0;i < length;i++ )
				{
					child = item( i );
					if( child.localName == name )
					{
						children.splice( i, 1 );
						return child;
					}
				}
			}
			return null;
		}
	
		/*
		Object NamedNodeMap
		The NamedNodeMap object has the following properties:
		
		length
		This read-only property is of type Number.
		
		The NamedNodeMap object has the following methods:
		
		getNamedItem(name)
		This method returns a Node object.
		The name parameter is of type String.
		
		setNamedItem(arg)
		This method returns a Node object.
		The arg parameter is a Node object.
		This method can raise a DOMException object.
		
		removeNamedItem(name)
		This method returns a Node object.
		The name parameter is of type String.
		This method can raise a DOMException object.
		
		item(index)
		This method returns a Node object.
		The index parameter is of type Number.
		Note: This object can also be dereferenced using square bracket notation (e.g. obj[1]). Dereferencing with an integer index is equivalent to invoking the item method with that index.
		
		
		
		
		
		
		getNamedItemNS(namespaceURI, localName)
		This method returns a Node object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		setNamedItemNS(arg)
		This method returns a Node object.
		The arg parameter is a Node object.
		This method can raise a DOMException object.
		
		removeNamedItemNS(namespaceURI, localName)
		This method returns a Node object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		This method can raise a DOMException object.	
	
		*/
	}
}