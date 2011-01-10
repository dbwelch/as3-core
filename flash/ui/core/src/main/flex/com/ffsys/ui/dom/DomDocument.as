package com.ffsys.ui.dom
{	
	/**
	*	An abstract implementation of a <code>DOM</code>
	* 	document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class DomDocument extends Node
		implements IDomDocument
	{	
		private var _head:IDocumentHead;
		private var _body:IDocumentBody;
		
		
		
		/*

Object Document
Document has the all the properties and methods of the Node object as well as the properties and methods defined below.
The Document object has the following properties:
doctype
This read-only property is a DocumentType object.
implementation
This read-only property is a DOMImplementation object.
documentElement
This read-only property is a Element object.
The Document object has the following methods:
createElement(tagName)
This method returns a Element object.
The tagName parameter is of type String.
This method can raise a DOMException object.
createDocumentFragment()
This method returns a DocumentFragment object.
createTextNode(data)
This method returns a Text object.
The data parameter is of type String.
createComment(data)
This method returns a Comment object.
The data parameter is of type String.
createCDATASection(data)
This method returns a CDATASection object.
The data parameter is of type String.
This method can raise a DOMException object.
createProcessingInstruction(target, data)
This method returns a ProcessingInstruction object.
The target parameter is of type String.
The data parameter is of type String.
This method can raise a DOMException object.
createAttribute(name)
This method returns a Attr object.
The name parameter is of type String.
This method can raise a DOMException object.
createEntityReference(name)
This method returns a EntityReference object.
The name parameter is of type String.
This method can raise a DOMException object.
getElementsByTagName(tagname)
This method returns a NodeList object.
The tagname parameter is of type String.
importNode(importedNode, deep)
This method returns a Node object.
The importedNode parameter is a Node object.
The deep parameter is of type Boolean.
This method can raise a DOMException object.
createElementNS(namespaceURI, qualifiedName)
This method returns a Element object.
The namespaceURI parameter is of type String.
The qualifiedName parameter is of type String.
This method can raise a DOMException object.
createAttributeNS(namespaceURI, qualifiedName)
This method returns a Attr object.
The namespaceURI parameter is of type String.
The qualifiedName parameter is of type String.
This method can raise a DOMException object.
getElementsByTagNameNS(namespaceURI, localName)
This method returns a NodeList object.
The namespaceURI parameter is of type String.
The localName parameter is of type String.
getElementById(elementId)
This method returns a Element object.
The elementId parameter is of type String.

		*/
		
		/**
		* 	Creates a <code>DomDocument</code> instance.
		*/
		public function DomDocument( xml:XML = null )
		{
			_nodeType = Node.DOCUMENT_NODE;
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get head():IDocumentHead
		{
			return _head;
		}
		
		public function set head( value:IDocumentHead ):void
		{
			_head = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get body():IDocumentBody
		{
			return _body;
		}
		
		public function set body( value:IDocumentBody ):void
		{
			_body = value;
		}
		
		/**
		* 	The document element.
		*/
		public function get documentElement():IDocumentBody
		{
			return _body;
		}
	}
}