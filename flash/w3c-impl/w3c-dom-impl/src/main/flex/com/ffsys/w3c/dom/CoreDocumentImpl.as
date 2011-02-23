package com.ffsys.w3c.dom
{	
	import flash.display.*;
	
	import com.ffsys.ioc.*;
	
	import javax.xml.*;
	import org.w3c.dom.*;
	
	import com.ffsys.w3c.dom.ioc.*;
	
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
	dynamic public class CoreDocumentImpl extends ParentNode
		implements Document
	{
		/**
		* 	The node name for document nodes.
		*/
		public static const NODE_NAME:String = "#document";		
		
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
		
		private var _elements:Vector.<Element>;
		
		/**
		* 	@private
		*/
		protected var _documentElement:Element;
		
		/**
		* 	Creates a <code>CoreDocumentImpl</code> instance.
		*/
		public function CoreDocumentImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.DOCUMENT_NODE;
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
			if( documentElement is NodeImpl )
			{
				x = NodeImpl( this.documentElement ).xml;
			}
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
			return _documentElement;
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
			var output:NodeListImpl = new NodeListImpl();
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
			var element:Element = null;
			
			if( !XMLGrammar.isValidXMLName( tagName ) )
			{
				throw new DOMException(
					DOMException.INVALID_XML_NAME_MSG,
					null,
					DOMException.INVALID_CHARACTER_ERR,
					[ tagName ] );
			}
			
			try
			{
				//TODO: handle namespace prefixes when looking via bean document
				
				//try to extract as a bean with the tag name
				element = Element( getDomBean(
					tagName ) );
			}catch( e:Error )
			{
				//no stress we'll create an element finally
			}finally
			{
				if( element == null )
				{
					//TODO: extract namespace uri based on any tag name prefix	
					element = new ElementImpl( this, tagName );
				}
			}
			return element;
		}
		
		/*
		
		NAMESPACE_ERR: Raised if the qualifiedName is a malformed qualified name,
		if the qualifiedName has a prefix and the namespaceURI is null,
		or if the qualifiedName has a prefix that is "xml" and the
		namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
		[XML Namespaces] , or if the qualifiedName or its prefix is "xmlns"
		and the namespaceURI is different from "http://www.w3.org/2000/xmlns/",
		or if the namespaceURI is "http://www.w3.org/2000/xmlns/" and neither
		the qualifiedName nor its prefix is "xmlns".
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function createElementNS( 
			namespaceURI:String, qualifiedName:String ):Element
		{
			var element:Element = null;
			
			if( implementation != null
				&& !implementation.hasFeature( DOMFeature.XML_MODULE, null ) )
			{
				throw new DOMException(
					DOMException.UNSUPPORTED_FEATURE_MODULE_MSG,
					null,
					DOMException.NOT_SUPPORTED_ERR,
					[ DOMFeature.XML_MODULE ] );
			}
			
			if( !XMLGrammar.isValidXMLName( qualifiedName ) )
			{
				throw new DOMException(
					DOMException.INVALID_XML_NAME_MSG,
					null,
					DOMException.INVALID_CHARACTER_ERR,
					[ qualifiedName ] );
			}
			
			try
			{
				element = Element( getDomBean(
					qualifiedName, null, namespaceURI ) );
			}catch( e:Error )
			{
				//no specific bean declared for the element
			}finally{
				element = new ElementImpl(
					this,					
					qualifiedName );
					//TODO: extract prefix from namespaceURI
					//new QName( namespaceURI, qualifiedName ) );
			}
			
			NodeImpl( element ).setNamespaceURI( namespaceURI );
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
				TextImpl.NAME, { data: data } ) );
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
			var instruction:ProcessingInstructionImpl = ProcessingInstructionImpl(
				getDomBean(
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
		
		/**
		* 	@inheritDoc
		*/
		public function adoptNode( source:Node ):Node
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function normalizeDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function renameNode(
			n:Node,
			namespaceURI:String,
			qualifiedName:String ):Node
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
			
			if( bean is NodeImpl )
			{
				NodeImpl( bean ).setOwnerDocument( this );
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
			if( child is NodeImpl )
			{
				NodeImpl( child ).setOwnerDocument( this );
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
				if( element is NodeImpl
					&& NodeImpl( element ).id != null )
				{
					var existing:Element = _identifiers[ NodeImpl( element ).id ] as Element;
					
					//TOOD: re-integrate this
					
					/*
					if( existing != null )
					{
						throw new Error( "Duplicate id found '" + element.id + "' on " + element );
					}
					*/
					
					_identifiers[ NodeImpl( element ).id ] = element;
				}
				
				//all currently registered elements
				elements.push( element );
				
				var nm:String = NodeImpl( element ).beanName;
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