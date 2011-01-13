package com.ffsys.dom
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
	dynamic public class Document extends VisualElement
	{
		private var _identifiers:Object = new Object();
		private var _tags:Object = new Object();
		
		private var _doctype:DocumentType;
		private var _implementation:DOMImplementation;
		
		/**
		* 	Creates a <code>Document</code> instance.
		*/
		public function Document( xml:XML = null )
		{
			_nodeType = Node.DOCUMENT_NODE;
			super( xml );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function createAttribute( name:String ):Attr
		{
			var output:Attr = new Attr( this.xml, name );
			return output;
		}
		
		/**
		* 	Ensures that the elements for a document
		* 	are created from a fresh list.
		*/
		override public function get elements():Vector.<Element>
		{
			if( _elements == null )
			{
				_elements = new Vector.<Element>();
			}
			return _elements;
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
		public function onload():void
		{
			trace("[ON LOAD] Document::onload()", this, this.id );
		}
		
		/**
		* 	The document element.
		*/
		public function get documentElement():Element
		{
			return this;
		}
		
		/**
		* 	Ensures that access by identifier at the document
		* 	level applies to all elements in the document.
		* 
		* 	@param id The identifier of the element to retrieve.
		* 
		* 	@return The retrieved element if it exists otherwise <code>null</code>.
		*/
		override public function getElementById( id:String ):Element
		{
			return _identifiers[ id ] as Element;
		}
		
		/**
		* 	Ensures that a document attempts to retrieve
		* 	tag elements from both the head and the body
		* 	of the document.
		* 
		* 	@param tagName The name of the tag to retrieve.
		* 
		* 	@return A list of child elements that are the
		* 	specified tag.
		*/
		override public function getElementsByTagName( tagName:String ):NodeList
		{
			return _tags[ tagName ];
		}
		
		/**
		* 	The document type for this document.
		*/
		public function get doctype():DocumentType
		{
			return _doctype;
		}
		
		/**
		* 	@private
		*/
		internal function setDocumentType( doctype:DocumentType ):void
		{
			_doctype = doctype;
		}
		
		/**
		* 	The implementation that created this document.
		*/
		public function get implementation():DOMImplementation
		{
			return _implementation;
		}
		
		/**
		* 	@private
		*/
		internal function setImplementation( implementation:DOMImplementation ):void
		{
			_implementation = implementation;
		}
		
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

				*/
		/**
		* 	Ensures that child nodes receive the correct
		* 	owner document reference when appended.
		*/	
		override public function appendChild( child:Node ):Node
		{
			super.appendChild( child );
			if( child != null )
			{
				child.setOwnerDocument( this );
			}
			return child;
		}
		
		override protected function propertyMissing( name:* ):*
		{
			var element:Element = _identifiers[ name ] as Element;
			if( element != null )
			{
				return element;
			}
			return super.propertyMissing( name );
		}
				
		internal function registerElement( element:Element ):void
		{
			if( element != null && element != this )
			{
				//trace("[REGISTER ELEMENT] Document::registerElement()", element );
				
				if( element.id != null )
				{
					var existing:Element = _identifiers[ element.id ] as Element;
					
					if( existing != null )
					{
						throw new Error( "Duplicate id found '" + element.id + "' on " + element );
					}
					_identifiers[ element.id ] = element;
				}
				elements.push( element );
				
				var nm:String = element.beanName;
				if( nm != null )
				{
					//keep track of document elements by tag name
					var exists:NodeList = _tags[ nm ] as NodeList;
					if( exists == null )
					{
						_tags[ nm ] = new NodeList();
					}
					_tags[ nm ].children.push( element );
				}
			}
		}
	}
}