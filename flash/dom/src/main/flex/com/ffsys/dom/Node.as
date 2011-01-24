package com.ffsys.dom
{ 
	import com.ffsys.utils.string.PropertyNameConverter;	
	
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
		
		private var _nodeValue:String;
		private var _parentNode:Node;
		private var _ownerDocument:Document;
		private var _childNodes:NodeList;
		private var _attributes:NamedNodeMap;
		private var _qualifiedName:QName;
		private var _propertyName:String;
		private var _childIndex:int;
		private var _namespaceURI:String;
		
		/**
		* 	@private
		*/
		protected var _prefix:String;
		
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
		* 	A namespace prefix associated with this node.
		*/
		public function get prefix():String
		{
			if( _prefix == null )
			{
				
				/*
				if( ownerElement )
				{
					_prefix = ownerElement.getPrefixByNamespace(
						new Namespace( this.namespaceURI ) );
				}
				*/
			}
			return _prefix;
		}
		
		public function set prefix( value:String ):void
		{
			//This property is of type String and can raise a DOMException object on setting.
			_prefix = value;
		}
		
		/**
		* 	A namespace <code>URI></code> for this node.
		*/
		public function get namespaceURI():String
		{
			//TODO: implement setting this when the input xml defines a namespace
			return _namespaceURI;
		}
		
		/**
		* 	@private
		*/
		internal function setNamespaceURI( uri:String ):void
		{
			_namespaceURI = uri;
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
			return -1;
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
		* 	The name of this node converted to
		* 	a camel case representation with any
		* 	hyphens removed suitable for setting
		* 	as a property name on a dynamic object.
		*/
		public function get propertyName():String
		{
			if( _propertyName == null )
			{
				_propertyName = localName;
				if( _propertyName.indexOf( "-" ) > -1 )
				{
					var converter:PropertyNameConverter = new PropertyNameConverter();
					_propertyName = converter.convert( _propertyName );
				}
			}
			return _propertyName;
		}
		
		/**
		* 	@private
		* 
		* 	Invoked by the parser so that this node knows
		* 	about any associated namespace.
		*/
		internal function setQualifiedName( qname:QName ):void
		{
			_qualifiedName = qname;
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
		* 	Removes all child nodes from this node.
		*/
		public function clear():void
		{
			var children:Vector.<Node> = childNodes.children.slice();
			for( var i:int = 0;i < children.length;i++ )
			{
				//trace("Node::clear()", i, length );
				removeChild( children[ i ] );
			}
		}
		
		/**
		* 	Determines whether this node has any child nodes.
		*/
		public function hasChildNodes():Boolean
		{
			return childNodes.length > 0;
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
		* 	The previous sibling of this node
		* 	if this node has a previous sibling
		* 	otherwise <code>null</code>.
		*/
		public function get previousSibling():Node
		{
			if( parentNode != null
				&& childIndex >= 1 )
			{
				return parentNode.childNodes[ childIndex - 1 ];
			}
			return null;
		}
		
		/**
		* 	The next sibling of this node
		* 	if this node has a next sibling
		* 	otherwise <code>null</code>.
		*/
		public function get nextSibling():Node
		{
			if( parentNode != null
				&& childIndex > -1
				&& childIndex < ( parentNode.childNodes.length - 1 ) )
			{
				return parentNode.childNodes[ childIndex + 1 ];
			}
			return null;
		}
		
		/**
		* 	The index of this node in a parent
		* 	node list.
		*/
		public function get childIndex():int
		{
			return _childIndex;
		}
		
		/**
		* 	@private
		*/
		internal function setChildIndex( index:int ):void
		{
			_childIndex = index;
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
			//This method can raise a DOMException object.	
			
			if( child != null && child != this )
			{
				child.setParentNode( this );
				child.setChildIndex( childNodes.length );
				child.setOwnerDocument( _ownerDocument );
				childNodes.concat( child );
				
				if( _ownerDocument && ( child is Element ) )
				{	
					_ownerDocument.registerElement( Element( child ) );
				}
				this.xml.appendChild( child.xml );
				
				//TODO: property name camel case conversion
				var name:String = child.tagName;
					
				//also assign a reference by property name
				this[ name ] = child;
				
				child.added();
			}
			return child;
		}
		
		public function removeChild( child:Node ):Node
		{
			//This method can raise a DOMException object.
			
			if( child != null )
			{
				childNodes.remove( child );
				
				//inform of the removal
				child.removed();
				
				//no parent as the node is now detached from the DOM
				child.setParentNode( null );
				child.setChildIndex( -1 );
				
				//trace("Node::removeChild()", this, child );
				
				var index:int = child.xml.childIndex();
				
				if( child.xml != null )
				{
					if( this.xml && index > -1 )
					{
						delete this.xml.children()[ index ];
					}else{
						child.xml = null;
						var x:XML = null;
						for( var i:int = 0;i < this.xml.children().length();i++ )
						{
							x = this.xml.children()[ i ];
							if( x.toString() == child.xml.toString() )
							{
								delete this.xml.children()[ i ];
							}
						}
					}
				}
			}
			return child;
		}
		
		/**
		* 	Inserts a node before another node.
		* 
		* 	@param child The new child to insert.
		* 	@param before The existing reference node to insert before.
		* 
		* 	@return The new child node.
		*/
		public function insertBefore( child:Node, before:Node ):Node
		{
			//TODO
			//This method can raise a DOMException object.			
			return child;
		}
		
		/**
		* 	Replaces a node with another node.
		* 
		* 	@param child The new child to insert.
		* 	@param before The existing reference node to replace.
		* 
		* 	@return The new child node.
		*/
		public function replaceChild( child:Node, existing:Node ):Node
		{
			//TODO
			//This method can raise a DOMException object.			
			return child;	
		}
		
		/**
		* 	Determines whether a feature is supported.
		* 
		* 	@param feature The feature name.
		* 	@param version A version for the feature.
		* 
		* 	@return Whether the feature is supported.
		*/
		public function isSupported(
			feature:String, version:String ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	Normalizes adjacent text nodes into
		* 	a single text node.
		*/
		public function normalize():void
		{
			//TODO
		}
		
		/**
		* 	Retrieves a clone of this node.
		* 
		* 	@param deep Whether child nodes should also be cloned.
		* 
		* 	@return A clone of this node.
		*/
		public function cloneNode( deep:Boolean ):Node
		{
			//TODO
			return null;
		}
		
		/**
		* 	@private
		* 
		* 	Invoked when this node is added to the <code>DOM</code>.
		*/
		internal function added():void
		{
			//
		}
		
		
		/**
		* 	@private
		* 
		* 	Invoked when this node is removed from the <code>DOM</code>.
		*/
		internal function removed():void
		{
			//
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
	}
}