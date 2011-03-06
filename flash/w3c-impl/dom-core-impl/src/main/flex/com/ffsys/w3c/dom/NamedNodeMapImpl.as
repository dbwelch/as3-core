package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	import java.lang.JavaObject;
	import java.util.Collection;
	import java.util.Map;
	import java.util.TreeMap;
	
	/**
	* 	@inheritDoc
	*/
	dynamic public class NamedNodeMapImpl extends JavaObject
		implements NamedNodeMap
	{
		private var _backing:Map;
		
		/**
		* 	Creates a <code>NamedNodeMapImpl</code> instance.
		*/
		public function NamedNodeMapImpl()
		{
			super();
			_backing = new TreeMap();
		}
		
		/**
		* 	Retrieves the underlying map that backs this
		* 	named node map.
		*/
		public function map():Map
		{
			return _backing;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return _backing.size();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):Node
		{
			var values:Collection = _backing.values();
			return values[ index ] as Node;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getNamedItem( name:String ):Node
		{
			
			/*
			var node:Node = null;
			for each( node in this )
			{
				if( node.nodeName == name )
				{
					return node;
				}
			}
			return null;
			*/
			
			return _backing.item( name ) as Node;
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
			
			/*
			var node:Node = null;
			for each( node in this )
			{
				if( node == item )
				{
					return true;
				}
			}
			return false;
			*/
			
			return _backing.containsValue( item );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setNamedItem( item:Node ):Node
		{
			if( item != null && item.nodeName != null )
			{
				/*
				var existing:Node = getNamedItem( item.nodeName );
				
				//trace("NamedNodeMap::setNamedItem() [BEFORE]", item, item.localName, existing, length );
				
				if( existing == null )
				{
					concat( item );
				}else{
					removeNamedItem( existing.nodeName );
					concat( item );
				}
				
				//trace("NamedNodeMap::setNamedItem() [AFTER]", item, length );
				*/
				
				_backing.put( item.nodeName, item );
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
				
				/*
				var child:Node = null;
				for( var i:int = 0;i < length;i++ )
				{
					child = item( i );
					if( child.nodeName == name )
					{
						children.splice( i, 1 );
						return child;
					}
				}
				*/
				
				_backing.remove( name );				
			}
			return null;
		}
		
		/**
		*	TODO
		*/
		public function getNamedItemNS(
			namespaceURI:String, localName:String ):Node
		{
			//TODO
			return null;
		}
		
		/**
		* 	TODO
		*/
		public function setNamedItemNS( arg:Node ):Node
		{
			//TODO			
			return null;
		}
		
		/**
		* 	TODO
		*/
		public function removeNamedItemNS(
		 	namespaceURI:String, localName:String ):Node
		{
			//TODO
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
		This method can raise a DomException object.
		
		removeNamedItem(name)
		This method returns a Node object.
		The name parameter is of type String.
		This method can raise a DomException object.
		
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
		This method can raise a DomException object.
		
		removeNamedItemNS(namespaceURI, localName)
		This method returns a Node object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		This method can raise a DomException object.	
	
		*/
	}
}