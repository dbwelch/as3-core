package com.ffsys.ui.dom
{
	
	
	dynamic public class Element extends Node
	{
		/**
		* 	Creates an <code>Element</code> instance.
		*/
		public function Element( xml:XML = null )
		{
			_nodeType = Node.ELEMENT_NODE;
			super( xml );
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
	}
}