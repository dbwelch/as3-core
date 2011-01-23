package com.ffsys.dom
{	
	import flash.display.*;
	
	import com.ffsys.ioc.*;
	
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
		* 	The document title.
		*/
		public function get title():String
		{
			if( this.head != null && this.head.title is NodeList )
			{
				//trace("Document::get title()", this.head.title[ 0 ].text );
				return this.head.title[ 0 ].text();
			}
			return null;
		}
		
		public function set title( value:String ):void
		{
			if( this.head == null )
			{
				var head:Element = createElement( DomIdentifiers.HEAD );
				var title:Element = createElement( DomIdentifiers.TITLE );
				title.appendChild( createTextNode( value ) );
				head.appendChild( title );
				appendChild( head );
			}else if( this.head != null && this.head.title is NodeList )
			{
				trace("Document::set title()", value );
				this.head.title[ 0 ].text( value );
			}
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
		* 	Ensures namespace declarations for the document
		* 	are included in the <code>XML</code> document.
		*/
		override public function get xml():XML
		{
			var x:XML = super.xml;
			addNamespaceAttributes( x );
			return x;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function onload():void
		{
			//trace("[ON LOAD] Document::onload()", this, this.id );
		}
		
		/**
		* 	Ensures that when no owner document has been specified a document
		* 	will consider itself as the owner.
		*/
		override public function get ownerDocument():Document
		{
			var doc:Document = super.ownerDocument;
			if( doc == null )
			{
				doc = this;
			}
			return doc;
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
			//trace("Document::getElementsByTagName()", tagName, _tags[ tagName ] );
			return _tags[ tagName ];
		}
		
		override public function getChildrenByTagName( tagName:String ):NodeList
		{
			//filter children for tag name matches
			var output:NodeList = new NodeList();
			var elem:Element = null;
			for each( elem in elements )
			{
				if( elem.tagName == tagName )
				{
					output.concat( elem );
				}
			}
			return output;
		}
		
		public function getElementsByTagNameNS( namespaceURI:String, localName:String ):NodeList
		{
			//
			return null;
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
		
		/**
		* 	Creates an element by tag name.
		* 
		* 	@param tagName The tag name of the element to create.
		* 
		* 	@return The created element.
		*/
		public function createElement( tagName:String ):Element
		{
			var element:Element = Element( getDomBean(
				tagName ) );
			return element;
		}
		
		/**
		* 	Creates an element by tag name within a namespace.
		* 
		* 	@param namespaceURI The <code>URI</code> of the namespace.
		* 	@param qualifiedName The qualified name of the tag.
		* 
		* 	@return The created element.
		*/
		public function createElementNS( 
			namespaceURI:String, qualifiedName:String ):Element
		{
			//TODO
			return null;
		}
		
		/**
		* 	Creates a document fragment.
		* 
		* 	@return A document fragment.
		*/
		public function createDocumentFragment():DocumentFragment
		{
			var fragment:DocumentFragment = DocumentFragment( getDomBean(
				DomIdentifiers.DOCUMENT_FRAGMENT ) );
			return fragment;
		}
		
		/**
		* 	Creates a text node.
		* 
		* 	@param data The data for the text node.
		* 
		* 	@return A text node implementation.
		*/
		public function createTextNode( data:String ):Text
		{
			var text:Text = Text( getDomBean(
				DomIdentifiers.TEXT, { data: data } ) );
			return text;
		}
		
		/**
		* 	Creates a comment node.
		* 
		* 	@param data The data for the comment.
		* 
		* 	@return A comment node implementation.
		*/
		public function createComment( data:String ):Comment
		{
			var comment:Comment = Comment( getDomBean(
				DomIdentifiers.COMMENT, { data: data } ) );
			return comment;
		}
		
		/**
		* 	Creates a cdata node.
		* 
		* 	@param data The data for the cdata node.
		* 
		* 	@return A cdata node implementation.
		*/
		public function createCDATASection( data:String ):CDATASection
		{
			var cdata:CDATASection = CDATASection( getDomBean(
				DomIdentifiers.CDATA_SECTION, { data: data } ) );
			return cdata;
		}
		
		/**
		* 	Creates a processing instruction node.
		* 
		* 	@param target A target for the processing instruction.
		* 	@param data The data for the processing instruction.
		* 
		* 	@return A processing instruction implementation.
		*/
		public function createProcessingInstruction(
			target:String, data:String ):ProcessingInstruction
		{
			var instruction:ProcessingInstruction = ProcessingInstruction( getDomBean(
				DomIdentifiers.PROCESSING_INSTRUCTION, { data: data } ) );
			instruction.setTarget( target );
			return instruction;
		}
		
		/**
		* 	Creates an attribute.
		* 
		* 	@param name The name of the attribute.
		* 
		* 	@return The created attribute.
		*/
		public function createAttribute( name:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				DomIdentifiers.ATTR,
					{ name: name } ) );
			
			//trace("Document::createAttribute()", attr, attr.name );
			return attr;
		}
		
		/**
		* 	Creates an attribute in a namespace.
		* 
		* 	@param namespaceURI The URI of the namespace.
		* 	@param qualifiedName The qualified name of the attribute.
		* 
		* 	@return The created attribute.
		*/
		public function createAttributeNS(
			namespaceURI:String, qualifiedName:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				DomIdentifiers.ATTR,
					{ name: qualifiedName, uri: namespaceURI } ) );
			
			//trace("Document::createAttributeNS()", attr );
			return attr;
		}
		
		/**
		* 	Creates an entity reference.
		* 
		* 	@param name The name of the entity reference.
		* 
		* 	@return An entity reference implementation.
		*/
		public function createEntityReference( name:String ):EntityReference
		{
			//TODO: check this
			//{ name: name }
			var ref:EntityReference = EntityReference( getDomBean(
				DomIdentifiers.ENTITY_REFERENCE ) );
			return ref;
		}
		
		public function importNode( source:Node, deep:Boolean ):Node
		{
			//
			return null;
		}
		
		//TODO: implement and change return type to display object
		public function getComponent( name:String ):Object
		{
			return null;
		}
		
		private function getComponentBean( beanName:String ):Object
		{
			return null;
		}
		
		private function getDomBean( beanName:String, properties:Object = null ):Object
		{
			if( this.document == null )
			{
				//TODO: move to DomException
				throw new Error( "Cannot retrieve a DOM bean with no valid bean document." );
			}
			
			var descriptor:IBeanDescriptor = this.document.getBeanDescriptor(
				beanName );
				
			if( descriptor == null )
			{
				throw new Error( "Could not locate an implementation for bean identifier '"
				 	+ beanName + "'." );
			}
			
			var bean:Object = descriptor.getBean( true, false );
			
			//trace("Document::getDomBean()", descriptor, bean );
			
			if( bean != null
				&& properties != null )
			{
				var z:String = null;
				for( z in properties )
				{
					if( bean.hasOwnProperty( z ) )
					{
						bean[ z ] = properties[ z ];
					}
				}
			}
			
			if( bean is Node )
			{
				Node( bean ).setOwnerDocument( this );
			}
			
			//register the element with this document
			/*
			if( bean is Element )
			{
				registerElement( Element( bean ) );
			}
			*/
			
			bean.finalized();
			return bean;
		}
		
				/*

		Object Document
		Document has the all the properties and methods of the Node object as well as the properties and methods defined below.

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
		The data parameter is of type String.\
		This method can raise a DOMException object.
		
		createAttribute(name)
		This method returns a Attr object.
		The name parameter is of type String.
		This method can raise a DOMException object.
		
		createAttributeNS(namespaceURI, qualifiedName)
		This method returns a Attr object.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
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
				if( element.id != null )
				{
					var existing:Element = _identifiers[ element.id ] as Element;
					
					//TOOD: re-integrate this
					
					/*
					if( existing != null )
					{
						throw new Error( "Duplicate id found '" + element.id + "' on " + element );
					}
					*/
					
					_identifiers[ element.id ] = element;
				}
				
				//all currently registered elements
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
					_tags[ nm ].concat( element );
					
				
					//trace("[REGISTER ELEMENT] Document::registerElement()", element, element.id, nm, _tags[ nm ].length );					
				}
			}
		}
	}
}