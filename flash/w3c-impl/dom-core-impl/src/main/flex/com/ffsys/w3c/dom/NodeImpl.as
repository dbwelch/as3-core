package com.ffsys.w3c.dom
{ 
	import java.lang.Cloneable;
	import java.io.Serializable;
	
	import org.w3c.dom.*;
	import org.w3c.dom.events.DOMEvent;
	import org.w3c.dom.events.EventListener;	
	import org.w3c.dom.events.EventTarget;
	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	
	import org.flashx.utils.string.PropertyNameConverter;
	
	import javax.xml.namespace.QualifiedName;
	
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
		implements Node, EventTarget, Cloneable, Serializable
	{
		/**
		* 	@private
		*/
		static private var _converter:PropertyNameConverter =
			new PropertyNameConverter();
		
		/**
		* 	@private
		*/
		protected var __ownerNode:Node;
		
		/**
		* 	@private
		*/
		protected var _ownerDocument:Document;
		
		private var _nodeName:String;
		private var _nodeValue:String;
		private var _childNodes:NodeListImpl;
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
		* 	@private
		*/
		protected var __flags:uint;
		
		/**
		* 	@private
		*/
	    protected static const READONLY:uint     	= 0x1<<0;
	
		/**
		* 	@private
		*/
	    protected static const SYNCDATA:uint     	= 0x1<<1;
		
		/**
		* 	@private
		*/
	    protected static const SYNCCHILDREN:uint 	= 0x1<<2;
	
		/**
		* 	@private
		*/
	    protected static const OWNED:uint        	= 0x1<<3;
	
		/**
		* 	@private
		*/
	    protected static const FIRSTCHILD:uint   	= 0x1<<4;
	
		/**
		* 	@private
		*/
	    protected static const SPECIFIED:uint    	= 0x1<<5;
	
		/**
		* 	@private
		*/
	    protected static const IGNORABLEWS:uint  	= 0x1<<6;
	
		/**
		* 	@private
		*/
	    protected static const HASSTRING:uint    	= 0x1<<7;
	
		/**
		* 	@private
		*/
	    protected static const NORMALIZED:uint 		= 0x1<<8;
	
		/**
		* 	@private
		*/
	    protected static const ID:uint           	= 0x1<<9;
		
		/**
		* 	Creates a <code>NodeImpl</code> instance.
		* 
		* 	@param owner The owner of the node.
		*/
		public function NodeImpl( owner:CoreDocumentImpl = null )
		{
			super();
			if( owner != null )
			{
				setOwnerDocument( owner );
			}
		}
		
		/**
		* 	@private
		*/
		internal function setOwnerNode( n:Node ):void
		{
			__ownerNode = n;
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
			return nodeValue;  // overriden in some subclasses
		}
		
		public function set textContent( value:String ):void
		{
			this.nodeValue = value;
		}
		
		/**
		* 	@inheritDoc
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
			if( _nodeName != null )
			{
				return _nodeName;
			}
			return this.beanName;
		}
		
		/**
		* 	@private
		* 
		* 	Allows derived implementations to set the
		* 	node name.
		*/
		protected function setInternalNodeName(
			name:String, uri:String = null ):void
		{
			setNodeName( name, uri );
		}
		
		/**
		* 	@private
		*/
		internal function setNodeName( name:String, uri:String = null ):Namespace
		{
			var ns:Namespace = null;
			if( name != null )
			{
				_nodeName = name;
				
				//trace("[SETTING NODE NAME] NodeImpl::setNodeName()", this, name );
				
				//TOOD: check if all this is necessary?
				var index:int = name.indexOf( ":" );
				var prefixSpecified:Boolean = index > -1;
				var specified:String = null;
				var prefix:String = lookupPrefix( uri );
				
				if( prefix != null )
				{
					ns = lookupNamespace( prefix );
				}
				
				if( prefixSpecified )
				{
					specified = name.substr( 0, index );
				}
				
				if( uri != null && uri.length > 0 )
				{
					//specified a namespace URI but no existing
					//prefix could be located for the URI so we define
					//a new namespace in this scope
					if( prefix == null )
					{
						if( prefixSpecified )
						{
							//trace("[SET NAME] NodeImpl::setNodeName()", specified, uri );
								
							if( ns == null )
							{		
								ns = new Namespace( specified, uri );
								namespaceDeclarations.push( ns );
							}
							
							//prefix = specified;
							
							//extract the local part of the name
							name = name.substr( index + 1 );
							
						}else{
							//the prefix must be valid as we have a namespaceURI
							//specified and an unqualified name
							
							/*
							if( prefix == null )
							{
								throw new DOMException(
									DOMException.INVALID_NAMESPACE_URI_MSG,
									null,
									DOMException.NAMESPACE_ERR,
									[ uri ] );
							}
							*/
						}
					}
				}else if( uri == null )
				{
					
					/*
					if( prefixSpecified )
					{
						//try to find a ns uri for the specified prefix
						uri = lookupNamespaceURI( specified );
						if( uri == null )
						{
							throw new DOMException(
								DOMException.INVALID_NAMESPACE_PREFIX_MSG,
								null,
								DOMException.NAMESPACE_ERR,
								[ specified ] );
						}
					}
					*/
				}
			}
			
			/*
			trace("[RENAME NODE -- NS ] NodeImpl::setNodeName()", ns  );
			*/
			
			return ns;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get localName():String
		{
			//TODO
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
		* 	@inheritDoc
		*/
		public function hasAttributes():Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get attributes():NamedNodeMap
		{
			return null;
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
			var ns:Namespace = lookupNamespace( prefix );
			if( ns != null )
			{
				return ns.uri;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function lookupNamespace( prefix:String ):Namespace
		{
			if( prefix != null )
			{
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.prefix != null
						&& child.prefix.length > 0
						&& prefix == child.prefix )
					{
						return child;
					}
				}
			}
			return null;
		}		
		
		/**
		* 	The namespace declarations for this node.
		*/
		public function get namespaceDeclarations():Array
		{
			if( _namespaceDeclarations == null )
			{
				if( !( ownerDocument is CoreDocumentImpl ) || ( ownerDocument == this ) )
				{
					_namespaceDeclarations = new Array();
				}else
				{
					_namespaceDeclarations = CoreDocumentImpl( ownerDocument ).namespaceDeclarations.slice();
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
		* 	@private
		* 
		* 	Finds the first ancestor that is an element.
		* 
		* 	@param currentNode The node to search from.
		* 
		* 	@return The first ancestor that is an element.
		*/
	    protected function getElementAncestor( currentNode:Node ):Element
		{
	        var parent:Node = currentNode.parentNode;
	        while( parent != null )
			{
	            if( parent.nodeType == NodeType.ELEMENT_NODE )
				{
	                return Element( parent );
	            }
	            parent = parent.parentNode;
	        }
	        return null;
	    }
		
		/**
		* 	@inheritDoc
		*/
		public function isSameNode( other:Node ):Boolean
		{
			return ( this == other );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEqualNode( arg:Node ):Boolean
		{
			if( arg == this )
			{
				return true;
			}
			
			if( arg.nodeType != nodeType )
			{
				return false;
			}
			
			// in theory nodeName can't be null but better be careful
			// who knows what other implementations may be doing?...
			if( nodeName == null )
			{
				if( arg.nodeName != null )
				{
					return false;
				}
			}else if( nodeName != arg.nodeName )
			{
				return false;
			}

			if( localName == null )
			{
				if( arg.localName != null )
				{
					return false;
				}
			}else if( localName != arg.localName )
			{
				return false;
			}

			if( namespaceURI == null )
			{
				if( arg.namespaceURI != null )
				{
					return false;
				}
			}else if( namespaceURI != arg.namespaceURI )
			{
				return false;
			}

			if( prefix == null )
			{
				if ( arg.prefix != null )
				{
					return false;
				}
			}else if( prefix != arg.prefix )
			{
				return false;
			}

			if( nodeValue == null )
			{
				if( arg.nodeValue != null )
				{
					return false;
				}
			}else if( nodeValue != arg.nodeValue )
			{
				return false;
			}

			return true;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isSupported(
			feature:String = null, version:String = null ):Boolean
		{
			return ownerDocument.implementation.hasFeature( feature, version );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFeature(
			feature:String, version:String ):Object
		{
			//REVISIT: should this return the feature from the implementation if supported?
			return isSupported( feature, version ) ? this : null;
		}
		
		/**
		* 	@inheritDoc
		* 
		* 	@todo Implement the node user data handler logic.
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
				_childNodes.setOwnerNode( this );
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
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get firstChild():Node
		{
			try
			{
				return childNodes.item( 0 );
			}catch( e:Error )
			{
				//no child nodes
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get lastChild():Node
		{
			try
			{
				return childNodes.item(
					childNodes.length - 1 );
			}catch( e:Error )
			{
				//no child nodes
			}
			return null;
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
			return __ownerNode;
		}
		
		/**
		* 	@private
		*/
		internal function setParentNode( parent:Node ):void
		{
			__ownerNode = parent;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get ownerDocument():Document
		{
			//trace("[GET OWNER DOCUMENT] NodeImpl::get ownerDocument()", _ownerDocument );
			
			return _ownerDocument;
		}
		
		/**
		* 	@private
		*/
		internal function setOwnerDocument( owner:Document ):void
		{
			_ownerDocument = owner;
			
			/*
			trace("[SET OWNER] NodeImpl::setOwnerDocument()",
				_ownerDocument );
			*/
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
			}
			return child;
		}
		
		
		/**
		* 	@inheritDoc
		*/
		public function appendChild( child:Node ):Node
		{
			//This method can raise a DomException object.
			return insertBefore( child, null );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function insertBefore( child:Node, before:Node ):Node
		{
			//This method can raise a DomException object.			
			return child;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function replaceChild( child:Node, existing:Node ):Node
		{
			//This method can raise a DomException object.			
			return child;
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
		*	Denotes that this node has changed.
		*/
		protected function changed():void
		{
			// we do not actually store this information on every node, we only
			// have a global indicator on the Document. Doing otherwise cost us too
			// much for little gain.
			CoreDocumentImpl( ownerDocument ).changed();
		}

		/**
		* 	@private
		* 	
		*	Returns the number of changes to this node.
		*/
		protected function changes():int
		{
			// we do not actually store this information on every node, we only
			// have a global indicator on the Document. Doing otherwise cost us too
			// much for little gain.
			return CoreDocumentImpl( ownerDocument ).changes();
		}

		/**
		* 	@private
		* 	
		*	Override this method in subclass to hook in efficient
		*	internal data structure.
		*/
		protected function synchronizeData():void
		{
			// By default just change the flag to avoid calling this method again
			setNeedsSyncData( false );
		}
		
	    //
	    // EventTarget support
	    //
		
		/**
		* 	@inheritDoc
		*/
	    public function addEventListener(
			type:String, listener:EventListener, useCapture:Boolean ):void
		{
	        CoreDocumentImpl( ownerDocument ).addNodeEventListener( this, type, listener, useCapture );
	    }
		
		/**
		* 	@inheritDoc
		*/
	    public function removeEventListener(
			type:String, listener:EventListener, useCapture:Boolean ):void
		{
	        CoreDocumentImpl( ownerDocument ).removeNodeEventListener(
				this, type, listener, useCapture );
	    }

		/**
		* 	@inheritDoc
		*/
	    public function dispatchEvent( event:DOMEvent ):Boolean
		{
	        return CoreDocumentImpl( ownerDocument ).dispatchNodeEvent( this, event );
	    }		
		
		public function getElements( deep:Boolean = false ):NodeList
		{
			if( hasChildNodes() )
			{
				return NodeListImpl( childNodes ).getNodesOfType(
					NodeType.ELEMENT_NODE, deep );
			}
			return new NodeListImpl();
		}
		
		/**
		* 	@deprecated See getElements()
		* 	
		* 	Retrieves a list of child nodes that are elements.
		*/
		public function get elements():Vector.<Element>
		{
			var elements:Vector.<Element> = new Vector.<Element>();
			var node:Node = null;
			for each( node in childNodes )
			{
				if( node is Element )
				{
					elements.push( Element( node ) );
				}
			}
			return elements;
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

	    /*
		*	Flags setters and getters, reproduced from the xerces-j
		*	implementation.
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether this node is read only.
		*/
		public function isReadOnly():Boolean
		{
			return ( __flags & READONLY ) != 0;
	    }
		
		/**
		* 	@private
		*/
	    internal function setReadOnly( value:Boolean, deep:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | READONLY : __flags & ~READONLY ) );
	    }
		
		/**
		* 	@private
		*/
		public function needsSyncData():Boolean
		{
			return ( __flags & SYNCDATA ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setNeedsSyncData( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | SYNCDATA : __flags & ~SYNCDATA ) );
	    }
		
		/**
		* 	@private
		*/
		public function needsSyncChildren():Boolean
		{
			return ( __flags & SYNCCHILDREN ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setNeedsSyncChildren( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | SYNCCHILDREN : __flags & ~SYNCCHILDREN ) );
	    }

		/**
		* 	@private
		*/
	    public function isOwned():Boolean
		{
			return ( __flags & OWNED ) != 0;
	    }
	
		/**
		* 	@private
		*/
	    internal function setIsOwned( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | OWNED : __flags & ~OWNED ) );
	    }
		
		/**
		* 	@private
		*/
		public function isFirstChild():Boolean
		{
			return ( __flags & FIRSTCHILD ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setFirstChild( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | FIRSTCHILD : __flags & ~FIRSTCHILD ) );
	    }

		/**
		* 	@private
		*/
		public function isSpecified():Boolean
		{
			return ( __flags & SPECIFIED ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setIsSpecified( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | SPECIFIED : __flags & ~SPECIFIED ) );
	    }

		/**
		* 	@private
		* 	
		* 	Inconsistent name to avoid clash with public method on TextImpl.
		*/
		public function internalIsIgnorableWhitespace():Boolean
		{
	        return ( __flags & IGNORABLEWS ) != 0;
	    }
	
		/**
		* 	@private
		*/
	    internal function setInternalIsIgnorableWhitespace( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | IGNORABLEWS : __flags & ~IGNORABLEWS ) );
	    }
		
		/**
		* 	@private
		*/
		public function hasStringValue():Boolean
		{
	        return ( __flags & HASSTRING ) != 0;
	    }
	
		/**
		* 	@private
		*/
	    internal function setHasStringValue( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | HASSTRING : __flags & ~HASSTRING ) );
	    }
		
		/**
		* 	@private
		*/
		public function isNormalized():Boolean
		{
			return ( __flags & NORMALIZED ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setIsNormalized( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | HASSTRING : __flags & ~HASSTRING ) );
	
	        // See if flag should propagate to parent.
			var o:NodeImpl = __ownerNode as NodeImpl;
	        if( !value && isNormalized() && o != null )
			{
				o.setNormalized( false );
	        }
	        __flags = uint( ( value ?  __flags | NORMALIZED : __flags & ~NORMALIZED ) );
	    }

		/**
		* 	@private
		*/
		public function isIdAttribute():Boolean
		{
			return ( __flags & ID ) != 0;
		}
		
		/**
		* 	@private
		*/
	    internal function setIsIdAttribute( value:Boolean ):void
		{
	        __flags = uint( ( value ? __flags | ID : __flags & ~ID ) );
	    }	
	}
}