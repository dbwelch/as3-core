package com.ffsys.dom
{
	
	
	dynamic public class Element extends Node
	{	
		/**
		* 	The attribute name that determines class style names.
		*/
		public static const CLASS:String = "class";
		
		/**
		* 	The name of the property used internally to store
		* 	class style names so that there is no conflict
		* 	with the <code>class</code> actionscript keyword.
		*/
		public static const CLASS_NAMES:String = "classNames";
		
		private var _classNames:String;
		
		/**
		*	@private	 
		*/
		protected var _elements:Vector.<Element>;
		
		/**
		* 	Creates an <code>Element</code> instance.
		*/
		public function Element( xml:XML = null )
		{
			_nodeType = Node.ELEMENT_NODE;
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get classNames():String
		{
			if( _classNames == null )
			{
				_classNames = "";
			}
			return _classNames;
		}
		
		public function set classNames( value:String ):void
		{
			_classNames = value;
		}
		
		/**
		* 	Determines whether the specified class name
		* 	exists on this instance.
		* 
		* 	@param name The class name to test for existence.
		* 
		* 	@return Whether the class name has been assigned to this
		* 	implementation.
		*/
		public function hasClass( name:String ):Boolean
		{
			return new RegExp( " ?" + name + " ?" ).test( classNames );
		}
		
		/**
		* 	Adds a class name to this element.
		* 
		* 	@param name The class name to add.
		*/
		public function addClass( name:String ):String
		{
			var nm:String = this.classNames;
			if( /[^\s]/.test( nm ) )
			{
				nm += " ";
			}
			nm += name;
			this.classNames = nm;
			//trace("Element::addClass()", this, this.classNames );
			return nm;
		}
		
		/**
		* 	An array of class names.
		*/
		public function get classes():Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			if( _classNames != null )
			{
				var parts:Array = _classNames.split( " " );
				for( var i:int = 0;i < parts.length;i++ )
				{
					output.push( String( parts[ i ] ) );
				}
			}			
			return output;
		}		
		
		/**
		* 	The name of the tag that created this element.
		*/
		public function get tagName():String
		{
			return beanName;
		}
		
		/**
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
		
		//TODO: implement as child nodes are added and removed
		/*
		private var _elements:Vector.<Element>;		
		override public function get elements():Vector.<Element>
		{
			if( _elements == null )
			{
				_elements = new Vector.<Element>();
			}
			return _elements;
		}
		*/
		
		/**
		* 	TODO
		*/
		public function setAttribute( name:String, value:String ):void
		{
			if( xml != null
				&& name != null
			 	&& value != null )
			{
				attributeSet( name, value );
			}
			
			var attr:Attr = ownerDocument.createAttribute(
				name );
				
			attr.value = value;
			
			trace("Element::setAttribute() attr: ", this, attr, attr.name, attr.value, attributes.length );			
			
			setAttributeNode( attr );
		}
		
		/**
		* 	TODO
		*/
		public function getAttribute( name:String ):String
		{
			var value:String = null;
			var attr:Attr = getAttributeNode( name );
			trace("Element::getAttribute()", name, attr, length );
			if( attr != null )
			{
				value = attr.value;
			}
			return value;
		}
		
		/**
		* 	TODO
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
		* 	TODO
		*/
		public function setAttributeNS(
			namespaceURI:String, qualifiedName:String, value:String ):void
		{
			//This method can raise a DOMException object.
			var attr:Attr = ownerDocument.createAttributeNS(
				namespaceURI, qualifiedName );
			attr.value = value;	
			setAttributeNode( attr );
		}
		
		/**
		* 	Retrieves an attribute node by name.
		* 
		* 	@param name The name of the attribute node.
		* 
		* 	@return The attribute node if it exists otherwise <code>null</code>.
		*/
		public function getAttributeNode( name:String ):Attr
		{
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr != null
					&& attr is Attr
				 	&& Attr( attr ).name == name )
				{
					break;
				}
			}
			return attr as Attr;
		}
		
		/**
		* 	Adds an attribute node to this element.
		* 
		* 	@param attr The attribute to add.
		* 
		* 	@return The attribute that was added or <code>null</code>
		* 	if the specified attribute was <code>null</code>.
		*/
		public function setAttributeNode( attr:Attr ):Attr
		{
			if( attr != null )
			{
				var qn:QName = new QName( attr.uri, attr.name );
				xml.@[ qn ] = attr.value;
				attr.setOwnerElement( this );
				attributes.setNamedItem( attr );	
			}
			return attr;
		}
		
		/**
		* 	Adds an attribute node to this element.
		* 
		* 	@param attr The attribute to add.
		* 
		* 	@return The attribute that was added or <code>null</code>
		* 	if the specified attribute was <code>null</code>.
		*/
		public function removeAttributeNode( attr:Attr ):Attr
		{
			var child:Attr = null;
			for( var i:int = 0;i < attributes.length;i++ )
			{
				child = attributes.item( i ) as Attr;
				if( child == attr )
				{
					var qn:QName = new QName( attr.uri, attr.name );
					delete xml.@[ qn ];
					attributes.removeNamedItem( child.name );
					break;
				}
			}
			return attr;
		}
		
		/**
		* 	Determines whether this element has the specified attribute.
		* 
		* 	@param name The local name of the attribute.
		* 
		* 	@param A boolean indicating whether the named attribute exists.
		*/
		public function hasAttribute( name:String ):Boolean
		{
			if( !hasAttributes() )
			{
				return false;
			}
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr is Attr
					&& Attr( attr ).name == name )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	Determines this elements has an attribute in the specified
		* 	namespace.
		* 
		* 	@param namespaceURI The <code>URI</code> for the namespace.
		* 	@param localName The local name for the namespace.
		* 
		* 	@return A boolean indicating whether an attribute exists
		* 	matching the specified namespace.
		*/
		public function hasAttributeNS( namespaceURI:String, localName:String ):Boolean
		{
			var attr:Attr = getAttributeNode( localName );
			return attr != null && attr.uri == namespaceURI;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):Element
		{
			return ownerDocument.getElementById( id );
		}
		
		/**
		* 	Retrieves direct child elements by tag name.
		* 
		* 	@param tagName The name of the tag to retrieve elements for.
		* 
		* 	@return A node list containing any matched elements. 
		*/
		public function getElementsByTagName( tagName:String ):NodeList
		{
			if( this[ tagName ] == null )
			{
				return new NodeList();
			}
			
			return this[ tagName ] as NodeList;
		}
		
		/**
		* 	Retrieves all descendants by tag name.
		* 
		* 	@param tagName The name of the tag to retrieve descendant elements for.
		* 
		* 	@return A node list containing any matched elements.
		*/
		public function getDescendantsByTagName( tagName:String ):NodeList
		{
			var list:NodeList = new NodeList();	
			
			if( this[ tagName ] is NodeList )
			{
				list.concat( NodeList( this[ tagName ] ) );
			}

			//append child element matches
			var elems:Vector.<Element> = this.elements;
			var child:Element = null;
			for each( child in elems )
			{
				list.concat( child.getDescendantsByTagName( tagName ) );
			}
			return list;
		}
		
		/*
		
		Object Element	
		Element has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The Element object has the following properties:
		
		tagName
		This read-only property is of type String.
		
		The Element object has the following methods:
		
		getAttribute(name)
		This method returns a String.
		The name parameter is of type String.
		
		setAttribute(name, value)
		This method has no return value.
		
		The name parameter is of type String.
		The value parameter is of type String.
		This method can raise a DOMException object.
		
		removeAttribute(name)
		
		This method has no return value.
		The name parameter is of type String.
		This method can raise a DOMException object.
		
		getAttributeNode(name)
		This method returns a Attr object.
		The name parameter is of type String.
		
		setAttributeNode(newAttr)
		This method returns a Attr object.
		The newAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		removeAttributeNode(oldAttr)
		This method returns a Attr object.
		The oldAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		getAttributeNS(namespaceURI, localName)
		This method returns a String.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		setAttributeNS(namespaceURI, qualifiedName, value)
		This method has no return value.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
		The value parameter is of type String.
		This method can raise a DOMException object.
		
		removeAttributeNS(namespaceURI, localName)
		This method has no return value.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		This method can raise a DOMException object.
		
		
		
		getAttributeNodeNS(namespaceURI, localName)
		This method returns a Attr object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		setAttributeNodeNS(newAttr)
		This method returns a Attr object.
		The newAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		
		
		getElementsByTagNameNS(namespaceURI, localName)
		This method returns a NodeList object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		
		
		hasAttribute(name)
		This method returns a Boolean.
		The name parameter is of type String.
		
		hasAttributeNS(namespaceURI, localName)
		This method returns a Boolean.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		*/
		
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
					trace("Element::importAttributes() beanName/name/value/local: ", beanName, name.localName, value, local );
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
		protected function attributeSet( name:String, value:String ):void
		{
			//trace("Element::attributeSet()", name, value, xml.@[name], hasOwnProperty( name ) );
			
			if( hasOwnProperty( name ) )
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
			this[ name ] = value;	
			
			//trace("Element::doWithProperty() AFTER SETTING THE PROPERTY: ", this, name, this[ name ] );		
		}
		
		/**
		* 	@private
		*/
		protected function doWithMissingProperty( name:String, value:String ):void
		{
			switch( name )
			{
				case CLASS:
					this[ CLASS_NAMES ] = value;
					
					//trace("Element::doWithMissingProperty()", "[SETTING CLASS NAMES]", value );
					break;
			}
		}			
	}
}