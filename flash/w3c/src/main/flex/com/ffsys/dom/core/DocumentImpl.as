package com.ffsys.dom.core
{	
	import flash.display.*;
	
	import com.ffsys.ioc.*;
	import org.w3c.dom.*;
	
	import com.ffsys.dom.ioc.*;
	
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
	dynamic public class DocumentImpl extends NodeImpl
		implements Document
	{
		private var _identifiers:Object = new Object();
		private var _tags:Object = new Object();
		
		private var _doctype:DocumentType;
		private var _implementation:DOMImplementation;
		
		private var _inputEncoding:String;
		private var _xmlEncoding:String;
		private var _xmlStandalone:Boolean;
		private var _xmlVersion:String;
		private var _strictErrorChecking:Boolean = true;
		private var _documentURI:String;
		private var _domConfig:DOMConfiguration;
		
		/**
		* 	Creates a <code>DocumentImpl</code> instance.
		*/
		public function DocumentImpl( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.DOCUMENT_NODE;
		}
		
		/**
		* 	The document title.
		*/
		
		/*
		override public function get title():String
		{
			if( this.head != null )
			{
				var titles:NodeList = this.head.getElementsByTagName(
					DomCoreBeanDocument.TITLE );				
				var element:Element = titles[ 0 ] as Element;
				return element != null ? element.text() as String : super.title;
			}
			return super.title;
		}
		
		override public function set title( value:String ):void
		{
			if( this.head == null )
			{
				var head:Element = createElement( DomCoreBeanDocument.HEAD );
				var title:Element = createElement( DomCoreBeanDocument.TITLE );
				title.appendChild( createTextNode( value ) );
				head.appendChild( title );
				appendChild( head );
			}else if( this.head != null )
			{
				var titles:NodeList = this.head.getElementsByTagName(
					DomCoreBeanDocument.TITLE );				
				var element:Element = titles[ 0 ] as Element;
				if( element != null )
				{
					element.text( value );
				}
			}
			super.title = value;
		}
		*/
		
		/**
		* 	Ensures that the elements for a document
		* 	are created from a fresh list.
		*/
		public function get elements():Vector.<Element>
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
		* 	@inheritDoc
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
		public function getElementById( id:String ):Element
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
		public function getElementsByTagName( tagName:String ):NodeList
		{
			//trace("Document::getElementsByTagName()", tagName, _tags[ tagName ] );
			return _tags[ tagName ];
		}
		
		public function getChildrenByTagName( tagName:String ):NodeList
		{
			//filter children for tag name matches
			var output:NodeList = new NodeListImpl();
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
		* 	@inheritDoc
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
		* 	@inheritDoc
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
		* 	@inheritDoc
		*/
		public function get inputEncoding():String
		{
			return _inputEncoding;
		}
		
		/**
		* 	@private
		*/
		internal function setInputEncoding( encoding:String ):void
		{
			_inputEncoding = encoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlEncoding():String
		{
			return _xmlEncoding;
		}
		
		/**
		* 	@private
		*/
		internal function setXmlEncoding( encoding:String ):void
		{
			_xmlEncoding = encoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlStandalone():Boolean
		{
			return _xmlStandalone;
		}		
		
		public function set xmlStandalone( value:Boolean ):void
		{
			_xmlStandalone = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlVersion():String
		{
			return _xmlVersion;
		}
		
		public function set xmlVersion( value:String ):void
		{
			_xmlVersion = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get strictErrorChecking():Boolean
		{
			return _strictErrorChecking;
		}
		
		public function set strictErrorChecking( value:Boolean ):void
		{
			_strictErrorChecking = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get documentURI():String
		{
			return _documentURI;
		}
		
		public function set documentURI( value:String ):void
		{
			_documentURI = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get domConfig():DOMConfiguration
		{
			return _domConfig;
		}
		
		/**
		* 	@private
		*/
		internal function setDomConfig( config:DOMConfiguration ):void
		{
			_domConfig = config;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createElement( tagName:String ):Element
		{
			var element:Element = Element( getDomBean(
				tagName ) );
			return element;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createElementNS( 
			namespaceURI:String, qualifiedName:String ):Element
		{
			var element:Element = Element( getDomBean(
				qualifiedName, null, namespaceURI ) );
			element.setNamespaceURI( namespaceURI );
			return element;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createDocumentFragment():DocumentFragment
		{
			var fragment:DocumentFragment = DocumentFragment( getDomBean(
				DomCoreBeanDocument.DOCUMENT_FRAGMENT ) );
			return fragment;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTextNode( data:String ):Text
		{
			var text:Text = Text( getDomBean(
				DomCoreBeanDocument.TEXT, { data: data } ) );
			return text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createComment( data:String ):Comment
		{
			var comment:Comment = Comment( getDomBean(
				DomCoreBeanDocument.COMMENT, { data: data } ) );
			return comment;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createCDATASection( data:String ):CDATASection
		{
			var cdata:CDATASection = CDATASection( getDomBean(
				DomCoreBeanDocument.CDATA_SECTION, { data: data } ) );
			return cdata;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createProcessingInstruction(
			target:String, data:String ):ProcessingInstruction
		{
			var instruction:ProcessingInstruction = ProcessingInstruction( getDomBean(
				DomCoreBeanDocument.PROCESSING_INSTRUCTION, { data: data } ) );
			instruction.setTarget( target );
			return instruction;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createAttribute( name:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				DomCoreBeanDocument.ATTR,
					{ name: name } ) );
			
			//trace("Document::createAttribute()", attr, attr.name );
			return attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createAttributeNS(
			namespaceURI:String, qualifiedName:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				DomCoreBeanDocument.ATTR,
					{ name: qualifiedName, uri: namespaceURI } ) );
			
			//trace("Document::createAttributeNS()", attr );
			return attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createEntityReference( name:String ):EntityReference
		{
			//TODO: check this
			//{ name: name }
			var ref:EntityReference = EntityReference( getDomBean(
				DomCoreBeanDocument.ENTITY_REFERENCE, { name: name } ) );
			return ref;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function importNode( source:Node, deep:Boolean ):Node
		{
			//TODO
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
		
		private function getDomBean(
			beanName:String,
			properties:Object = null,
			namespaceURI:String = null ):Object
		{
			if( this.document == null )
			{
				//TODO: move to DomException
				throw new Error( "Cannot retrieve a DOM bean with no valid bean document." );
			}
			
			var doc:IBeanDocument = this.document;
			
			if( namespaceURI != null
				&& doc.id != namespaceURI )
			{
				var xref:IBeanDocument = null;
				for each( xref in doc.xrefs )
				{
					if( xref.id == namespaceURI )
					{
						doc = xref;
						break;
					}
				}
			}
			
			var descriptor:IBeanDescriptor = doc.getBeanDescriptor(
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

		/**
		* 	@inheritDoc
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
						_tags[ nm ] = new NodeListImpl();
					}
					_tags[ nm ].concat( element );
					
				
					//trace("[REGISTER ELEMENT] Document::registerElement()", element, element.id, nm, _tags[ nm ].length );					
				}
			}
		}
	}
}