package com.ffsys.dom
{
	
	
	dynamic public class Element extends Node
	{		
		public static const CLASS:String = "class";
		
		public static const CLASS_NAMES:String = "classNames";
		
		private var _classNames:String;
		
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
		*/
		public function addClass( name:String ):void
		{
			var nm:String = this.classNames;
			if( /[^\s]/.test( nm ) )
			{
				nm += " ";
			}
			
			nm += name;
			
			this.classNames = nm;
			
			trace("Element::addClass()", this, this.classNames );
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
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
		* 	Ensures that attributes are assigned when an <code>XML</code>
		* 	fragment is assigned to this implementation.
		*/
		override public function set xml( value:XML ):void
		{
			super.xml = value;
			if( value != null )
			{
				doWithAttributes( value, this );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setAttribute( name:String, value:String ):void
		{
			if( xml != null
				&& name != null
			 	&& value != null )
			{
				xml.@[ name ] = value;
				attributeSet( name, value );
			}
			
			//TODO: handle registering event attributes
			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAttribute( name:String ):String
		{
			if( xml != null
			 	&& name != null )
			{
				return xml.@[ name ];
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeAttribute( name:String ):void
		{
			if( xml != null
			 	&& name != null )
			{
				delete xml.@[ name ];
			}
		}
		
		/*
		setAttributeNS(namespaceURI, qualifiedName, value)
		This method has no return value.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
		The value parameter is of type String.
		This method can raise a DOMException object.
		*/
		
		public function setAttributeNS(
			namespaceURI:String, qualifiedName:String, value:String ):void
		{
			var qn:QName = new QName( namespaceURI, qualifiedName );
			xml.@[ qn ] = value;
			trace("[SET ATTRIBUTE NS] Element::setAttributeNS()", xml.@[ qn ], qn.localName, qn.uri );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasAttribute( name:String ):Boolean
		{
			return hasAttributes() && name != null && xml.@[ name ].length() > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):Element
		{
			return ownerDocument.getElementById( id );
		}
		
		/**
		* 	
		*/
		public function getElementsByTagName( tagName:String ):NodeList
		{
			if( this[ tagName ] == null )
			{
				return new NodeList();
			}
			
			/*
			if( this[ tagName ] is NodeList )
			{
				list = NodeList( this[ tagName ] );
			}
			*/
			
			return this[ tagName ] as NodeList;
		}
		
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
		
		
		protected function doWithAttributes(
			node:XML, target:Element ):void
		{
			//trace("[DO WITH ATTRIBUTES] :::::::::::::: ", node.attributes().length(), node.name().localName );
			
			if( node.attributes().length() > 0 && target )
			{
				/*
				trace("::::::::::::::: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Element::doWithAttributes()",
					this,
					this.id,
					node.attributes().length() );
				*/
				
				var attrs:XMLList = node.@*;
				var attr:XML = null;
				var name:QName = null;
				var value:String = null;			
				
				var namespaces:XMLList = node.attributes();
				for each( attr in namespaces )
				{
					//trace("[GOT NAMESPACE ATTRIBUTE] Element::doWithAttributes()", attr );
					name = attr.name();
					value = attr.toString();
					trace("Element::doWithAttributes()", name, value, name is QName, name.localName, name.uri );
					
					//no qualified name
					if( !name.uri )
					{
						target.setAttribute( name.localName, value );
					}else{
						target.setAttributeNS( name.uri, name.localName, value );
					}
				}
				
				/*
				for each( attr in node.attributes() )
				{
					name = attr.name();
					value = node.@[ name ];
					trace("Element::doWithAttributes()", name, value, value is Namespace, value is QName );
					target.setAttribute( name, value );
				}
				*/
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