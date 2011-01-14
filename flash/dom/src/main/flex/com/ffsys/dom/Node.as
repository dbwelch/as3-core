package com.ffsys.dom
{ 
	/**
	*	Represents a <code>DOM</code> node.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class Node extends XmlAwareDomElement
	{
		/**
		* 	Constant representing an element node.
		*/
		public static const ELEMENT_NODE:Number = 1;
		
		/**
		* 	Constant representing an attribute node.
		*/
		public static const ATTRIBUTE_NODE:Number = 2;
		
		/**
		* 	Constant representing a text node.
		*/
		public static const TEXT_NODE:Number = 3;
		
		/**
		* 	Constant representing a cdata section node.
		*/
		public static const CDATA_SECTION_NODE:Number = 4;
		
		/**
		* 	Constant representing an entity reference node.
		*/
		public static const ENTITY_REFERENCE_NODE:Number = 5;
		
		/**
		* 	Constant representing an entity node.
		*/
		public static const ENTITY_NODE:Number = 6;
		
		/**
		* 	Constant representing a processing instruction node.
		*/
		public static const PROCESSING_INSTRUCTION_NODE:Number = 7;
		
		/**
		* 	Constant representing a comment node.
		*/
		public static const COMMENT_NODE:Number = 8;
		
		/**
		* 	Constant representing a document node.
		*/
		public static const DOCUMENT_NODE:Number = 9;
		
		/**
		* 	Constant representing a document type node.
		*/
		public static const DOCUMENT_TYPE_NODE:Number = 10;
		
		/**
		* 	Constant representing a document fragment node.
		*/
		public static const DOCUMENT_FRAGMENT_NODE:Number = 11;
		
		/**
		* 	Constant representing a notation node.
		*/
		public static const NOTATION_NODE:Number = 12;
		
		/**
		* 	@private
		*/
		protected var _nodeType:Number;
		
		private var _nodeValue:String;
		private var _parentNode:Node;
		private var _ownerDocument:Document;
		private var _childNodes:NodeList;
		private var _attributes:NamedNodeMap;
		
		/**
		* 	Creates a <code>Node</code> instance.
		* 
		* 	@param xml The <code>XML</code> that defined this node.
		*/
		public function Node( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The number of child nodes encapsulated
		* 	by this node.
		*/
		override public function get length():uint
		{
			return childNodes.children.length;
		}
		
		/**
		* 	The local name of this node.
		*/
		public function get nodeName():String
		{
			return beanName;
		}
		
		/**
		* 	The local name of this node.
		*/
		public function get localName():String
		{
			return beanName;
		}
		
		/**
		* 	The type of this node.
		*/
		public function get nodeType():Number
		{
			return _nodeType;
		}
		
		/**
		* 	A value for this node.
		*/
		public function get nodeValue():String
		{
			return _nodeValue;
		}
		
		public function set nodeValue( value:String ):void
		{
			_nodeValue = value;
		}
		
		/**
		* 	Determines whether this node has any attributes.
		* 
		* 	@return Whether this node has any attributes.
		*/
		public function hasAttributes():Boolean
		{
			return attributes.length  > 0;
		}
		
		/**
		* 	The list of child nodes that belong to this node.
		* 
		* 	@return The list of child nodes.
		*/
		public function get childNodes():NodeList
		{
			if( _childNodes == null )
			{
				_childNodes = new NodeList();
			}
			return _childNodes;
		}
		
		/**
		* 	Determines whether this node has any child nodes.
		*/
		public function hasChildNodes():Boolean
		{
			return length > 0;
		}
		
		/**
		* 	A first child node when this node
		* 	has children.
		*/
		public function get firstChild():Node
		{
			return childNodes.first();
		}
		
		/**
		* 	A last child node when this node
		* 	has children.
		*/
		public function get lastChild():Node
		{
			return childNodes.last();
		}
		
		/**
		* 	The parent of this node.
		*/
		public function get parentNode():Node
		{
			return _parentNode;
		}
		
		/**
		* 	@private
		*/
		internal function setParentNode( parent:Node ):void
		{
			_parentNode = parent;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get attributes():NamedNodeMap
		{
			if( _attributes == null )
			{
				_attributes = new NamedNodeMap();
			}
			return _attributes;
		}
		
		/**
		* 	The document that owns this node.
		*/
		public function get ownerDocument():Document
		{
			return _ownerDocument;
		}
		
		/**
		* 	@private
		*/
		internal function setOwnerDocument( owner:Document ):void
		{
			_ownerDocument = owner;
		}
		
		//TODO: modify the XML document as nodes are added and removed !!?!?!?!!?
		
		/**
		* 	Appends a node to the children of this node.
		* 
		* 	If the specified node is <code>null</code> it will
		* 	not be added.
		* 
		* 	@param child The node to append.
		* 
		* 	@return The specified child node.
		*/
		public function appendChild( child:Node ):Node
		{
			if( child != null )
			{
				child.setParentNode( this );
				child.setOwnerDocument( _ownerDocument );
				childNodes.concat( child );	
				
				/*
				trace("[ NODE -- APPENDING NODE ] Node::appendChild() this/child/length/children length: ",
					this, child, this.length, childNodes.children.length );
				*/
				
			}
			return child;
		}
		
		/**
		* 	Ensures the xml representation is in sync
		* 	with the attribute definitions for this node.
		*/
		override public function get xml():XML
		{
			var x:XML = super.xml;
			//
			if( x != null && !( this is Document ) )
			{
				x.removeNamespace( x.@xmlns );
			}
			return x;
		}
		
		/*

		nodeName
		This read-only property is of type String.
		
		nodeValue
		This property is of type String, can raise a DOMException object on setting and can raise a DOMException object on retrieval.
		
		nodeType
		This read-only property is of type Number.
		
		parentNode
		This read-only property is a Node object.
		
		childNodes
		This read-only property is a NodeList object.
		
		firstChild
		This read-only property is a Node object.
		
		lastChild
		This read-only property is a Node object.
		
		ownerDocument
		This read-only property is a Document object.
		
		localName
		This read-only property is of type String.
		
		
		
		
		
		
		
		previousSibling
		This read-only property is a Node object.
		
		nextSibling
		This read-only property is a Node object.
		
		attributes
		This read-only property is a NamedNodeMap object.
		
		namespaceURI
		This read-only property is of type String.
		
		prefix
		This property is of type String and can raise a DOMException object on setting.		
		
		*/
		
		/*
		
		appendChild(newChild)
		This method returns a Node object.
		The newChild parameter is a Node object.
		This method can raise a DOMException object.		
		
		insertBefore(newChild, refChild)
		This method returns a Node object.
		The newChild parameter is a Node object.
		The refChild parameter is a Node object.
		This method can raise a DOMException object.
		
		replaceChild(newChild, oldChild)
		This method returns a Node object.
		The newChild parameter is a Node object.
		The oldChild parameter is a Node object.
		This method can raise a DOMException object.
		
		removeChild(oldChild)
		This method returns a Node object.
		The oldChild parameter is a Node object.
		This method can raise a DOMException object.
		
		hasChildNodes()
		This method returns a Boolean.
		
		cloneNode(deep)
		This method returns a Node object.
		The deep parameter is of type Boolean.
		
		normalize()
		This method has no return value.
		
		isSupported(feature, version)
		This method returns a Boolean.
		The feature parameter is of type String.
		The version parameter is of type String.
		
		hasAttributes()
		This method returns a Boolean.		
		
		
		
		*/
		
	}
}