package com.ffsys.ui.dom
{
	
	
	dynamic public class Element extends Node
	{		
		public static const CLASS:String = "class";
		
		public static const STYLE_CLASS_NAMES:String = "styles";
		
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
		public function get tagName():String
		{
			return beanName;
		}
		
		override public function set xml( value:XML ):void
		{
			super.xml = value;
			
			//if( !( this is IDomDocument ) ) trace("Element::set xml()", value );
			
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
		public function getElementsByTagName():IDomNodeList
		{
			//TODO:
			return null;
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
		
		getElementsByTagName(name)
		This method returns a NodeList object.
		The name parameter is of type String.
		
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
				var name:String = null;
				var value:String = null;
				for each( attr in attrs )
				{
					name = attr.name();
					value = node.@[ name ];
					//trace("Element::set xml()", name, value );
					target.setAttribute( name, value );
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
					this[ STYLE_CLASS_NAMES ] = value;
					break;
			}
		}			
	}
}