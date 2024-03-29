/**
	<p>Concrete implementations of the interfaces
	defined in the org.w3c.dom package.</p>
	
	@todo Complete this implementation.
*/
package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;
	
	/**
	*	Represents a <code>DOM</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class ElementImpl extends ParentNode
		implements Element, ElementTraversal
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "Element";
		
		private var _title:String;
		
		/**
		*	@private	 
		*/
		protected var _elements:Vector.<Element>;
		
		private var _attributes:NamedNodeMap;		
		private var _tagName:String;
		
		/**
		* 	Creates an <code>ElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function ElementImpl(
			owner:CoreDocumentImpl = null,
			name:String = null )
		{
			super( owner );
			if( name != null )
			{
				setNodeName( name );
			}
		}
		
		/**
		* 	@private
		* 
		* 	Required so the 
		*/
		
		/*
		override internal function setNodeName( name:String, uri:String = null ):Namespace
		{
			var ns:Namespace = null
			try
			{
				//ensure that errors are caught
				//when calling super.setNodeName() so that invalid
				//names are not passed to setTagName()
				ns = super.setNodeName( name, uri );
				setTagName( name, ns );
			}catch( e:Error )
			{
				throw e;
			}
			return ns;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.ELEMENT_NODE;
		}
		
		/**
		* 	Attempts to retrieve a namespace prefix from
		* 	the namespace declarations assocaited with this element
		* 	based on the specified target namespace.
		* 
		* 	@param ns The target namespace.
		* 
		* 	@return The prefix for the namespace or <code>null</code>
		* 	if no matching namespace was found.
		*/
		public function getPrefixByNamespace( ns:Namespace ):String
		{
			if( ns != null )
			{
				var uri:String = ns.uri;
				
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.uri.length > 0
						&& ns.uri == child.uri )
					{
						return child.prefix;
					}
				}
			}
			return null;
		}
		
		/**
		* 	Attempts to retrieve a namespace URI from
		* 	the namespace declarations assocaited with this element
		* 	based on the specified prefix.
		* 
		* 	@param prefix The namespace prefix.
		* 
		* 	@return The <code>URI</code> for the namespace or <code>null</code>
		* 	if no matching namespace was found.
		*/
		public function getUriByPrefix( prefix:String ):String
		{
			if( prefix != null )
			{
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.prefix == prefix
						&& child.uri.length > 0 )
					{
						return child.uri;
					}
				}
			}
			return null;
		}
		
		private var _xmlns:String;
		
		/**
		* 	The XML namespace <code>URI</code> for this element.
		*/
		public function get xmlns():String
		{
			if( _xmlns == null )
			{
				var declarations:Array = this.namespaceDeclarations;
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( !child.prefix
						&& child.uri.length > 0 )
					{
						_xmlns = child.uri;
						break;
					}
				}
			}
			return _xmlns;
		}
		
		public function set xmlns( value:String ):void
		{
			var ns:String = this.xmlns;
			
			var declarations:Array = this.namespaceDeclarations;
			var child:Namespace = null;
			
			//no previous default namespace specified
			if( ns == null )
			{
				//create on our namespace declarations
				this.namespaceDeclarations.push(
					new Namespace( value ) );
			}else{
				//update an existing default declaration
				for( var i:int = 0;i < declarations.length;i++ )
				{
					child = declarations[ i ];
					if( !child.prefix
						&& child.uri.length > 0 )
					{
						declarations.splice( i, 1, new Namespace( value ) );
						break;
					}
				}
			}
			
			_xmlns = value;
		}
		
		/**
		* 	The language for this element.
		* 
		* 	The qualified <code>xml:lang</code> attribute is preferred
		* 	but if it is not present and a <code>lang</code>
		* 	attribute is available it will be used.
		*/
		public function get lang():String
		{
			//TODO: constants			
			var ns:String = "xml";
			var nm:String = "lang";
			var uri:String = getUriByPrefix( ns );				
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//check for non-qualified lang attribute
			if( attr == null )
			{
				attr = getAttributeNode( nm );
			}
			
			//attempt to retrieve a default language
			//at the document level
			if( attr == null
				&& ( ownerDocument is CoreDocumentImpl )
				&& ownerDocument != this )
			{
				return CoreDocumentImpl( ownerDocument ).lang;
			}
			
			return attr != null ? attr.value : null;
		}
		
		public function set lang( value:String ):void
		{
			//TODO: constants			
			var ns:String = "xml";
			var nm:String = "lang";
			var uri:String = getUriByPrefix( ns );
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//creating first time around
			if( attr == null && value != null )
			{

				attr = ownerDocument.createAttributeNS(
					uri, nm );
			}
			
			if( attr != null
				&& value != null )
			{
				attr.value = value;
			}else if( attr != null
				&& value == null )
			{
				//delete the language attribute on this element
				removeAttributeNode( attr );
				attr = null;				
			}
			
			if( attr != null )
			{
				setAttributeNode( attr );
			}
		}
		
		/**
		* 	An XML schema for this element.
		* 
		* 	Stored as the qualified <code>xml:xsi</code> attribute.
		*/
		public function get xsi():String
		{
			//TODO: constants
			var ns:String = "xml";
			var nm:String = "xsi";
			var uri:String = getUriByPrefix( ns );			
			
			var attr:Attr = getAttributeNodeNS( uri, nm );

			//attempt to retrieve a default xsi
			//at the document level
			if( attr == null
				&& ownerDocument is CoreDocumentImpl
				&& ( ownerDocument != this ) )
			{
				return CoreDocumentImpl( ownerDocument ).xsi;
			}
			return attr != null ? attr.value : null;
		}

		public function set xsi( value:String ):void
		{
			//TODO: constants
			var ns:String = "xml";
			var nm:String = "xsi";
			var uri:String = getUriByPrefix( ns );			
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//creating first time around
			if( attr == null )
			{
				attr = ownerDocument.createAttributeNS(
					uri, nm );
			}			
			
			if( attr != null
				&& value != null )
			{
				attr.value = value;
			}else if( attr != null
				&& value == null )
			{
				//delete the xsi attribute on this element
				removeAttributeNode( attr );
				attr = null;
			}
			
			if( attr != null )
			{
				setAttributeNode( attr );
			}
		}
		
		/**
		* 	@private
		* 	
		* 	Sets or retrieves the text of this element.
		* 
		* 	@param value A value to assign to the text
		* 	of this element.
		* 
		* 	@return This element when assigning text contents
		* 	or the cumulative text contents when retrieving
		* 	text values.
		*/
		protected function setText( value:String = null ):Object
		{
			if( ownerDocument == null
				|| ownerDocument.implementation == null )
			{
				throw new Error(
					"Cannot assign text content with no available DOM implementation." );
			}
			
			//trace("Element::text()", "[TEXT]", this, childNodes, value );
			
			//set a text value
			if( value != null )
			{
				//clear any existing child elements
				clear();
				
				//add the text
				appendChild(
					ownerDocument.createTextNode( value ) );
					
			//retrieve a cumulative value of all descendant text nodes
			}else{
				var txt:String = "";
				var elements:Vector.<Text> = this.textNodes;
				var child:Text = null;
				
				//trace("Element::text()", "[RETRIEVING CUMULATIVE TEXT]", elements );
				
				for( var i:int = 0;i < elements.length;i++ )
				{
					child = elements[ i ];
					txt += child.data;
				}
				return txt;
			}
			return this;
		}
		
		/**
		* 	Retrieves all descendant nodes that are
		* 	text.
		*/
		public function get textNodes():Vector.<Text>
		{
			var output:Vector.<Text> = new Vector.<Text>();
			var child:Node = null;
			for( var i:int = 0;i < childNodes.length;i++ )
			{
				child = childNodes[ i ];
				
				//trace("Element::get textNodes()", child, child is Text );
				
				if( child is Text )
				{
					output.push( Text( child ) );
				}else if( child is ElementImpl )
				{
					output = output.concat(
						ElementImpl( child ).textNodes );
				}
			}
			return output;
		}
		
		/**
		* 	Sets the markup of this element.
		* 
		* 	The markup parameter can be <code>XML</code>, <code>XMLList</code>
		* 	or a <code>String</code>.
		* 
		* 	By default markup is treated as inner markup. If you specify
		* 	the <code>inner</code> parameter as <code>false</code>
		* 	and the markup root node name matches the tag name
		* 	for this element then the entire markup block is parsed
		* 	into this element.
		* 
		* 	@param markup The markup for this element.
		* 	@param inner Whether the markup should be treated
		* 	as inner markup.
		* 
		* 	@return This element after the markup has been assigned.
		*/
		public function html( markup:Object, inner:Boolean = true ):Element
		{
			if( ownerDocument == null
				|| !( ownerDocument.implementation is DOMImplementationImpl ) )
			{
				throw new Error(
					"Cannot assign inner markup with no available DOM implementation." );
			}
			
			var tmp:XML = new XML( "<" + tagName + " />" );
			
			//convert string values to XMLList
			if( markup is String )
			{
				markup = new XMLList( markup );
			}
			
			if( !( markup is XML || markup is XMLList ) )
			{
				throw new Error( "Inner markup must be XML or an XMLList." );
			}
			
			if( markup is XML )
			{
				var mx:XML = markup as XML;
				if( mx.name()
					&& mx.name().localName == tagName
					&& !inner )
				{
					//matching root tag name use the entire xml block
					tmp = mx;
				}else
				{
					tmp.appendChild( mx );
				}
			}else if( markup is XMLList )
			{
				var node:XML = null;
				for each( node in XMLList( markup ) )
				{
					tmp.appendChild( node );
				}
			}
			
			//clear any existing child nodes before
			//assigning the markup
			clear();
			
			//parse the markup into this element
			DOMImplementationImpl( ownerDocument.implementation ).parse(
				tmp, null, this );
			
			return this;
		}
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		override public function get nodeName():String
		{
			trace("[ELEM GET NODE NAME] ElementImpl::get nodeName()", tagName );
			return tagName;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function get tagName():String
		{
			return nodeName;
			
			/*
			if( _tagName != null )
			{
				return _tagName;
			}
			return this.beanName;
			*/
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get schemaTypeInfo():TypeInfo
		{
			//TODO
			return null;
		}
		
		/**
		*	@inheritDoc 
		*/
		override public function get attributes():NamedNodeMap
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
		public function getAttribute( name:String ):String
		{
			var value:String = null;
			var attr:Attr = getAttributeNode( name );
			//trace("Element::getAttribute()", name, attr, length );
			if( attr != null )
			{
				value = attr.value;
			}
			return value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setAttribute( name:String, value:String ):void
		{
			var attr:Attr = ownerDocument.createAttribute(
				name );
				
			attr.value = value;
			
			//trace("Element::setAttribute() attr: ", this, attr, attr.name, attr.value, attributes.length );			
			
			setAttributeNode( attr );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeAttribute( name:String ):void
		{
			var attr:Attr = getAttributeNode( name );
			if( attr != null )
			{
				removeAttributeNode( attr );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAttributeNS(
			namespaceURI:String, localName:String ):String
		{
			var attr:Attr = getAttributeNodeNS( namespaceURI, localName );
			if( attr != null )
			{
				return attr.value;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setAttributeNS(
			namespaceURI:String,
			qualifiedName:String,
			value:String ):void
		{
			//trace("ElementImpl::setAttributeNS()", ownerDocument );
			
			//This method can raise a DomException object.
			var attr:Attr = ownerDocument.createAttributeNS(
				namespaceURI, qualifiedName );
			
			//trace("[SET ATTR NS] ElementImpl::setAttributeNS()", ownerDocument, attr );
				
			attr.value = value;	
			
			//trace("Element::setAttributeNS()", attr.name, attr.value, attr.uri );
			
			setAttributeNode( attr );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAttributeNode( localName:String ):Attr
		{
			/*
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr is Attr
				 	&& Attr( attr ).localName == localName )
				{
					return attr as Attr;
				}
			}
			*/
			return attributes.getNamedItem( localName ) as Attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setAttributeNode( attr:Attr ):Attr
		{
			if( attr is AttrImpl )
			{		
				var a:AttrImpl = AttrImpl( attr );
				
				a.setOwnerElement( this );
				
				//prevent duplicates
				if( hasAttribute( attr.nodeName ) )
				{
					var existing:Attr = a.isQualified()
						? getAttributeNodeNS( a.namespaceURI, attr.localName )
						: getAttributeNode( attr.localName );
					
					//trace("Element::setAttributeNode()", "[HAS EXISTING ATTRIBUTE MATCH]", existing, attr.value, existing.value );
					
					//update the attribute value and xml attribute
					if( existing != null
						&& attr.value != existing.value )
					{
						existing.value = attr.value;
						
						//trace("Element::setAttributeNode()", "[HAS EXISTING ATTRIBUTE MATCH]", existing );						
					}
					
					//update the XML representation of the attribute
					//this.xml.@[ attr.nodeName ] = attr.value;
					
					return existing;
				}
				
				attributes.setNamedItem( attr );
				
				//this.xml.@[ attr.nodeName ] = attr.value;
								
				//trace("[ATTR] Element::setAttributeNode()", this, attr, attr.nodeName, hasAttribute( attr.nodeName ), attr.isQualified(), attr.name, attr.value, attr.uri, attributes.length );
								
				if( attr.name != null
				 	&& attr.value != null )
				{
					attributeSet( attr );
				}
			}
			return attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeAttributeNode( attr:Attr ):Attr
		{
			if( attr != null )
			{
				attributes.removeNamedItem( attr.nodeName );
			}
			return attr;
		}
		
		/**
		*	@inheritDoc
		*/
		public function removeAttributeNS(
			namespaceURI:String,
			localName:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAttributeNodeNS(
			namespaceURI:String, localName:String ):Attr
		{
			var attr:Attr = getAttributeNode( localName );
			return ( attr != null && attr.namespaceURI == namespaceURI ) ? attr : null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setAttributeNodeNS( attr:Attr ):Attr
		{
			return setAttributeNode( attr );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasAttribute( name:String ):Boolean
		{
			if( !hasAttributes() )
			{
				return false;
			}
		
			//trace("Element::hasAttribute()", this, name, attributes );
			var attr:Node = null;
			for each( attr in attributes )
			{
				//trace("Element::hasAttribute() [ITEM]", attr, attr.nodeName );
				if( attr is Attr
					&& Attr( attr ).nodeName == name )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasAttributeNS( namespaceURI:String, localName:String ):Boolean
		{
			var attr:Attr = getAttributeNode( localName );
			return attr != null && attr.namespaceURI == namespaceURI;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setIdAttribute(
			name:String, isId:Boolean ):void
		{
			//TODO
		}
		
			
		/**
		* 	@inheritDoc
		*/
		public function setIdAttributeNS(
			namespaceURI:String,
			localName:String,
			isId:Boolean ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/
		public function setIdAttributeNode(
			idAttr:Attr, isId:Boolean ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):Element
		{
			return ownerDocument.getElementById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByTagName( tagName:String ):NodeList
		{
			var list:NodeListImpl = new NodeListImpl();
			//append child element matches
			var elems:Vector.<Element> = this.elements;
			var child:Element = null;
			for each( child in elems )
			{
				if( child is Element )
				{
					if( child.tagName == tagName )
					{
						list.concat( child );
					}
					list.concat(
						ElementImpl( child ).getChildrenByTagName( tagName ) );
				}
			}
			return list;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByTagNameNS(
			namespaceURI:String, localName:String ):NodeList
		{
			//TODO
			return null;
		}
		
		/**
		* 	Retrieves all descendants by tag name.
		* 
		* 	@param tagName The name of the tag to retrieve descendant elements for.
		* 
		* 	@return A node list containing any matched elements.
		*/
		public function getChildrenByTagName( tagName:String ):NodeList
		{
			if( !( this[ tagName ] is NodeList ) )
			{
				return new NodeListImpl();
			}
			return this[ tagName ] as NodeList;
		}
		
		
		/**
		* 	Retrieves a list of all attributes with the specified
		* 	<code>localName</code>.
		* 
		* 	@param localName The local name of the attribute to search for.
		* 
		* 	@return A list of all attributes whose <code>localName</code>
		* 	matches the specified <code>localName</code>.
		*/
		public function getAttributeNodeList( localName:String ):Vector.<Attr>
		{
			var output:Vector.<Attr> = new Vector.<Attr>();
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr is Attr
				 	&& Attr( attr ).localName == localName )
				{
					output.push( attr );
				}
			}
			return output;
		}
		
		/*
		*	ElementTraversal
		*/
		
		/**
		* 	The first child node that is an element.
		*/
		public function get firstElementChild():Element
		{
			var elems:Vector.<Element> = this.elements;
			if( elems.length > 0 )
			{
				return elems[ 0 ];
			}
			return null;
		}
		
		/**
		* 	The last child node that is an element.
		*/
		public function get lastElementChild():Element
		{
			var elems:Vector.<Element> = this.elements;
			if( elems.length > 0 )
			{
				return elems[ elems.length - 1 ];
			}
			return null;			
		}
		
		/**
		* 	The previous sibling node that is an element.
		*/
		public function get previousElementSibling():Element
		{
			if( parentNode != null
				&& childIndex > 0 )
			{
				var elems:Vector.<Element> = NodeImpl( parentNode ).elements;
				if( elems.length >= childIndex )
				{					
					try
					{
						return elems[ childIndex - 1 ];
					}catch( e:Error )
					{
						//ignore the index out of bounds exception for the moment
					}
				}
			}
			return null;
		}
		
		/**
		* 	The next sibling node that is an element.
		*/
		public function get nextElementSibling():Element
		{
			if( parentNode != null
				&& childIndex < ( parentNode.childNodes.length - 1 ) )
			{
				var elems:Vector.<Element> = NodeImpl( parentNode ).elements;
				if( elems.length > childIndex )
				{
					try
					{
						return elems[ childIndex + 1 ];
					}catch( e:Error )
					{
						//ignore the index out of bounds exception for the moment
					}
				}
			}
			return null;
		}
		
		/**
		* 	The number of child nodes that are elements.
		*/
		public function get childElementCount():uint
		{
			var elems:Vector.<Element> = this.elements;
			return elems.length;
		}
		
		/*
		*	Selector-API
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function matchesSelector(
			selectors:String,
			...referenceNodes ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Handles configuring attributes when an
		* 	XML node is associated with this element.
		*/
		protected function importAttributes(
			node:XML, target:Element ):void
		{
			if( node.attributes().length() > 0 && target )
			{
				/*
				trace("::::::::::::::: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Element::importAttributes()",
					this,
					this.id,
					node.attributes().length() );
				*/
				
				var child:XML = null;
				var name:QName = null;
				var value:String = null;
				
				var attrs:XMLList = node.attributes();
				for each( child in attrs )
				{
					name = child.name();
					value = child.toString();
					var local:Boolean = !name.uri;
					
					//trace("Element::importAttributes() beanName/name/value/local: ", beanName, name.localName, value, local );
					
					if( local )
					{
						target.setAttribute( name.localName, value );
					}else{
						target.setAttributeNS( name.uri, name.localName, value );
					}
				}
			}
		}		
		
		/**
		* 	@private
		*/
		protected function attributeSet( attr:Attr ):void
		{
			//trace("Element::attributeSet()", name, value, xml.@[name], hasOwnProperty( name ) );
			
			var name:String = attr.name;
			var value:String = attr.value;
			
			if( hasOwnProperty( name )
				&& this[ name ] != value )
			{
				doWithProperty( name, value );
			}else{
				doWithMissingProperty( name, value );
			}
		}
		
		/**
		* 	@private
		*/
		protected function doWithProperty( name:String, value:String ):void
		{
			//TODO: check for exception
			
			try
			{
				this[ name ] = value;	
			}catch( e:Error )
			{
				//fail silently when we can't assign the property
			}
			
			//trace("Element::doWithProperty() AFTER SETTING THE PROPERTY: ", this, name, this[ name ] );		
		}
		
		/**
		* 	@private
		*/
		protected function doWithMissingProperty( name:String, value:String ):void
		{
			//
		}
		
		/**
		* 	@private
		*/
		
		/*
		internal function setTagName( tagName:String, ns:Namespace = null ):void
		{
			if( tagName == null )
			{
				return;
			}
			trace("[SET TAG NAME] ElementImpl::setTagName()", tagName );
			_tagName = tagName;
		}
		*/
		
	    /**
	    * 	@private
	    * 	
		*	In "normal form" (as read from a source file), there will never be two
		*	Text children in succession. But DOM users may create successive Text
		*	nodes in the course of manipulating the document. Normalize walks the
		*	sub-tree and merges adjacent Texts, as if the DOM had been written out
		*	and read back in again. This simplifies implementation of higher-level
		*	functions that may want to assume that the document is in standard form.
		* 
		*	<p>To normalize a Document, normalize its top-level Element child.</p>
		* 
		*	<p>As of PR-DOM-Level-1-19980818, CDATA -- despite being a subclass of
		*	Text -- is considered "markup" and will _not_ be merged either with
		*	normal Text or with other CDATASections.</p>
		*/
	    override public function normalize():void
		{
	        // No need to normalize if already normalized.
	        if( isNormalized() )
			{
	            return;
	        }
	        if( needsSyncChildren() )
			{
	            synchronizeChildren();
	        }
	
	        var kid:Node
			var next:Node;
	        for( kid = firstChild; kid != null; kid = next )
			{
	            next = kid.nextSibling;
	            // If kid is a text node, we need to check for one of two
	            // conditions:
	            //   1) There is an adjacent text node
	            //   2) There is no adjacent text node, but kid is
	            //      an empty text node.
	            if ( kid.nodeType == NodeType.TEXT_NODE )
	            {
	                // If an adjacent text node, merge it with kid
	                if ( next != null
						&& next.nodeType == NodeType.TEXT_NODE )
	                {
	                    ( Text( kid ) ).appendData( next.nodeValue );
	                    removeChild( next );
	                    next = kid; // Don't advance; there might be another.
	                }
	                else
	                {
	                    // If kid is empty, remove it
	                    if( kid.nodeValue == null
							|| kid.nodeValue.length == 0 )
						{
	                        removeChild( kid );
	                    }
	                }
	            }
	            // Otherwise it might be an Element, which is handled recursively
	            else if( kid.nodeType == NodeType.ELEMENT_NODE )
				{
	                kid.normalize();
	            }
	        }

	        // We must also normalize all of the attributes
	        if ( attributes != null )
	        {
				var attr:Node = null;
	            for( var i:int = 0;i < attributes.length; i++ )
	            {
	                attr = attributes.item( i );
	                attr.normalize();
	            }
	        }

	    	// changed() will have occurred when the removeChild() was done,
	    	// so does not have to be reissued.

	        setIsNormalized(true);
	    } // normalize()
	}
}