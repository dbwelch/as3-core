package com.ffsys.ui.dom
{	
	import flash.display.*;
	
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
	dynamic public class DomDocument extends Element
		implements IDomDocument
	{
		private var _identifiers:Object = new Object();
		
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
		* 	@inheritDoc
		*/
		public function createAttribute( name:String ):Attr
		{
			var output:Attr = new Attr( this.xml, name );
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function getElementsByMatch( re:RegExp ):Vector.<DisplayObject>
		{
			var output:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			if( re != null )
			{
				var id:String = null;
				var display:DisplayObject = null;
				for( id in _identifiers )
				{
					if( re.test( id ) )
					{
						display = _identifiers[ id ] as DisplayObject;
						if( display != null )
						{
							output.push( display );
						}
					}
				}
			}
			return output;
		}
		
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
		public function get binding():Object
		{
			//return _binding;
			
			//TODO: re-implement with ERB style parsing
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get identifiers():Object
		{
			return _identifiers;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function prepared():void
		{
			//trace("Document::prepared()", this, numChildren, this.id );
		}
		
		/**
		* 	The document element.
		*/
		public function get documentElement():IDocumentBody
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		//TODO: change to Element return type
		public function getElementById( id:String ):IDomElement
		{
			return _identifiers[ id ] as IDomElement;
		}
	}
}