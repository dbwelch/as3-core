package com.ffsys.ui.dom
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
		implements IDomNode
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
		* 	The local name of this node.
		*/
		public function get nodeName():String
		{
			if( this.xml != null )
			{
				return this.xml.name().localName;
			}
			
			return null;
		}
		
		public function get nodeType():Number
		{
			return _nodeType;
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
		previousSibling
		This read-only property is a Node object.
		nextSibling
		This read-only property is a Node object.
		attributes
		This read-only property is a NamedNodeMap object.
		ownerDocument
		This read-only property is a Document object.
		namespaceURI
		This read-only property is of type String.
		prefix
		This property is of type String and can raise a DOMException object on setting.
		localName
		This read-only property is of type String.		
		
		*/
		
		/*
		
		
		
		
		
		
		
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
		appendChild(newChild)
		This method returns a Node object.
		The newChild parameter is a Node object.
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