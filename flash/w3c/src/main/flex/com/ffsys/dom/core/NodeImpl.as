package com.ffsys.dom.core
{ 
	import com.ffsys.utils.string.PropertyNameConverter;
	
	import com.ffsys.dom.core.support.AbstractNodeProxyImpl;
	
	import org.w3c.dom.*;
	
	/**
	*	Represents a <code>DOM</code> node.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class NodeImpl extends AbstractNodeProxyImpl
		implements Node
	{
		/**
		* 	@private
		*/
		static private var _converter:PropertyNameConverter =
			new PropertyNameConverter();		
		
		/**
		* 	The node is an Element.
		*/
		public static const ELEMENT_NODE:Number = 1;
		
		/**
		* 	The node is an Attr.
		*/
		public static const ATTRIBUTE_NODE:Number = 2;
		
		/**
		* 	The node is a Text node.
		*/
		public static const TEXT_NODE:Number = 3;
		
		/**
		* 	The node is a CDATASection.
		*/
		public static const CDATA_SECTION_NODE:Number = 4;
		
		/**
		* 	The node is an EntityReference.
		*/
		public static const ENTITY_REFERENCE_NODE:Number = 5;
		
		/**
		* 	The node is an Entity.
		*/
		public static const ENTITY_NODE:Number = 6;
		
		/**
		* 	The node is a ProcessingInstruction.
		*/
		public static const PROCESSING_INSTRUCTION_NODE:Number = 7;
		
		/**
		* 	The node is a Comment.
		*/
		public static const COMMENT_NODE:Number = 8;
		
		/**
		* 	The node is a Document.
		*/
		public static const DOCUMENT_NODE:Number = 9;
		
		/**
		* 	The node is a DocumentType.
		*/
		public static const DOCUMENT_TYPE_NODE:Number = 10;
		
		/**
		* 	The node is a DocumentFragment.
		*/
		public static const DOCUMENT_FRAGMENT_NODE:Number = 11;
		
		/**
		* 	The node is a Notation.
		*/
		public static const NOTATION_NODE:Number = 12;
		
		/**
		* 	The two nodes are disconnected. Order between
		* 	disconnected nodes is always implementation-specific.
		*/
		public static const DOCUMENT_POSITION_DISCONNECTED:Number = 0x01;
		
		/**
		* 	The second node precedes the reference node.	
		*/
		public static const DOCUMENT_POSITION_PRECEDING:Number = 0x02;
		
		/**
		* 	The node follows the reference node.
		*/
		public static const DOCUMENT_POSITION_FOLLOWING:Number = 0x04;
		
		/**
		* 	The node contains the reference node.
		* 	A node which contains is always preceding, too.
		*/
		public static const DOCUMENT_POSITION_CONTAINS:Number = 0x08;
		
		/**
		* 	The node is contained by the reference node.
		* 	A node which is contained is always following, too.
		*/
		public static const DOCUMENT_POSITION_CONTAINED_BY:Number = 0x10;
		
		/**
		* 	The determination of preceding versus
		* 	following is implementation-specific.
		*/
		public static const DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC:Number = 0x20;
		
		private var _nodeValue:String;
		private var _parentNode:Node;
		private var _ownerDocument:Document;
		private var _childNodes:NodeList;
		private var _attributes:NamedNodeMap;
		private var _qualifiedName:QName;
		private var _propertyName:String;
		private var _childIndex:int;
		private var _namespaceURI:String;
		private var _baseURI:String;
		
		private var _namespaceDeclarations:Array;
		
		/**
		* 	@private
		*/
		protected var _prefix:String;
		
		/**
		* 	Creates a <code>NodeImpl</code> instance.
		* 
		* 	@param xml The <code>XML</code> that defined this node.
		*/
		public function NodeImpl( xml:XML = null )
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
			//This property is of type String and can raise a DomException object on setting.
			_prefix = value;
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
		*/
		public function get baseURI():String
		{
			return _baseURI;
		}
		
		/**
		* 	@private
		*/
		internal function setBaseURI( uri:String ):void
		{
			_baseURI = uri;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get textContent():String
		{
			//TODO
			return null;
		}
		
		public function set textContent( value:String ):void
		{
			//TODO
			//_textContent = value;
		}
		
		/**
		* 	The number of child nodes encapsulated
		* 	by this node.
		*/
		override public function get length():uint
		{
			return childNodes.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get nodeName():String
		{
			return beanName;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get localName():String
		{
			return beanName;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get nodeType():Number
		{
			return -1;
		}
		
		/**
		* 	@inheritDoc
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
					_propertyName = _converter.convert( _propertyName );
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
		* 	@inheritDoc
		*/
		public function hasAttributes():Boolean
		{
			return attributes.length  > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function compareDocumentPosition( other:Node ):Number
		{
			//TODO
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isSameNode( other:Node ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function lookupPrefix( namespaceURI:String ):String
		{
			if( namespaceURI != null )
			{
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.uri.length > 0
						&& namespaceURI == child.uri )
					{
						return child.prefix;
					}
				}
			}		
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isDefaultNamespace( namespaceURI:String ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function lookupNamespaceURI( prefix:String ):String
		{
			//TODO
			return null;
		}
		
		/**
		* 	The namespace declarations for this node.
		*/
		public function get namespaceDeclarations():Array
		{
			if( _namespaceDeclarations == null )
			{
				if( !( ownerDocument is DocumentImpl ) || ( ownerDocument == this ) )
				{
					_namespaceDeclarations = new Array();
				}else
				{
					_namespaceDeclarations = DocumentImpl( ownerDocument ).namespaceDeclarations.slice();
				}
			}
			return _namespaceDeclarations;
		}
		
		public function set namespaceDeclarations( value:Array ):void
		{
			_namespaceDeclarations = value;
		}
		
		/**
		* 	Adds namespace declarations associated
		* 	with this element to the attributes of an XML element.
		* 
		* 	@param x The XML element.
		*/
		protected function addNamespaceAttributes( x:XML ):void
		{
			if( namespaceDeclarations != null )
			{
				//trace("[GOT NAMESPACE DECLARATION] Document::get xml()", namespaceDeclarations );
				var ns:Namespace = null;
				var nm:String = null;
				for each( ns in namespaceDeclarations )
				{
					if( !ns.prefix )
					{
						//continue;	
						nm = "xmlns";
					}else
					{
						nm = "xmlns:" + ns.prefix;
					}
					if( x.@[ nm ].length() == 0 )
					{
						x.@[ nm ] = ns.uri;
					}
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEqualNode( arg:Node ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFeature(
			feature:String, version:String ):Object
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setUserData(
			key:String, data:*, handler:UserDataHandler ):*
		{
			//TODO
			return null;
		}
		
		public function getUserData( key:String ):*
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get childNodes():NodeList
		{
			if( _childNodes == null )
			{
				_childNodes = new NodeListImpl();
			}
			return _childNodes;
		}
		
		/**
		* 	Removes all child nodes from this node.
		*/
		public function clear():void
		{
			
			/*
			var children:Vector.<Node> = childNodes.children.slice();
			for( var i:int = 0;i < children.length;i++ )
			{
				//trace("Node::clear()", i, length );
				removeChild( children[ i ] );
			}
			*/
			
			if( childNodes is NodeListImpl )
			{
				NodeListImpl( childNodes ).clear();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasChildNodes():Boolean
		{
			return childNodes.length > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get firstChild():Node
		{
			return childNodes.item( 0 );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get lastChild():Node
		{
			return childNodes.item( childNodes.length - 1 );
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
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
		* 	@inheritDoc
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
				_attributes = new NamedNodeMapImpl();
			}
			return _attributes;
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
		*/
		public function appendChild( child:Node ):Node
		{
			//This method can raise a DomException object.	
			
			if( child is NodeImpl )
			{
				var n:NodeImpl = NodeImpl( child );				
				n.setParentNode( this );
				n.setChildIndex( childNodes.length );
				n.setOwnerDocument( _ownerDocument );
				
				NodeListImpl( childNodes ).concat( n );
				
				if( _ownerDocument is DocumentImpl && ( n is Element ) )
				{	
					DocumentImpl( _ownerDocument ).registerElement( Element( n ) );
				}
				
				this.xml.appendChild( n.xml );
				
				//TODO: property name camel case conversion
				var name:String = n.nodeName;
					
				//also assign a reference by property name
				this[ name ] = n;
				
				n.added();
			}
			return child;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeChild( child:Node ):Node
		{
			//This method can raise a DomException object.
			
			var n:NodeImpl = child as NodeImpl;
			if( n != null )
			{
				NodeListImpl( childNodes ).remove( child );
				
				//inform of the removal
				n.removed();
				
				//no parent as the node is now detached from the DOM
				n.setParentNode( null );
				n.setChildIndex( -1 );
				
				//trace("Node::removeChild()", this, child );
				
				if( n.xml != null )
				{
					var index:int = n.xml.childIndex();
					if( this.xml && index > -1 )
					{
						delete this.xml.children()[ index ];
					}else{
						n.xml = null;
						var x:XML = null;
						for( var i:int = 0;i < this.xml.children().length();i++ )
						{
							x = this.xml.children()[ i ];
							if( x.toString() == n.xml.toString() )
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
		* 	@inheritDoc
		*/
		public function insertBefore( child:Node, before:Node ):Node
		{
			//TODO
			//This method can raise a DomException object.			
			return child;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function replaceChild( child:Node, existing:Node ):Node
		{
			//TODO
			//This method can raise a DomException object.			
			return child;	
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isSupported(
			feature:String = null, version:String = null ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function normalize():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
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