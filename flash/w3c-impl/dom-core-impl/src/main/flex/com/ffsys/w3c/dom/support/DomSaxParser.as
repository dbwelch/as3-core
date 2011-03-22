package com.ffsys.w3c.dom.support
{
	import org.w3c.dom.*;
		
	import org.flashx.net.asax.*;
	import org.flashx.ioc.support.xml.BeanSaxParser;
	import org.flashx.ioc.*;	
	import com.ffsys.w3c.dom.*;
	
	public class DomSaxParser extends BeanSaxParser
	{
		/**
		* 	The processing instruction that indicates that the next sibling
		* 	element and all it's child nodes should be excluded when
		* 	building the DOM.
		*/
		public static const EXCLUSION_PROCESSING_INSTRUCTION:String =
			"flash-dom-exclude";
			
		/**
		* 	The default namespace URI used if none
		* 	is specified on the document.
		*/
		public static const DEFAULT_NAMESPACE_URI:String =
			"http://www.w3.org/1999/xhtml";	
		
		private var _fragmented:Boolean;
		private var _dom:Element;
		private var _element:Node;
		private var _textData:String;
		private var _textStart:Object;
		private var _textType:String;
		private var _excludeNextElement:Boolean = false;
		private var _excludeNextElementDepth:uint = 0;
		
		private var _implementation:DOMImplementation;
		private var _namespaceURI:String;
		private var _qualifiedName:String;
		private var _type:DocumentType;
		private var _existing:Boolean;
		
		/**
		* 	Creates a <code>DomSaxParser</code> instance.
		*/
		public function DomSaxParser(
			implementation:DOMImplementation = null,
			type:DocumentType = null )
		{
			super();
			this.implementation = implementation;
			this.type = type;
		}
		
		/**
		* 	Starts traversal of the specified document.
		* 
		* 	@param x The <code>XML</code> document to traverse.
		*/
		override public function parse( x:XML ):void
		{
			if( x != null )
			{
			
				//a predefined root object indicates
				//parsing a partial into an existing element
	 			_existing = ( ( root as Element ) != null );
				
				super.parse( x );
			}
		}
		
		/**
		* 	The implementation used to create the document which
		* 	is used to create the document elements.
		*/
		public function get implementation():DOMImplementation
		{
			return _implementation;
		}
		
		public function set implementation( value:DOMImplementation ):void
		{
			_implementation = value;
		}
		
		/**
		* 	The document type.
		*/
		public function get type():DocumentType
		{
			return _type;
		}
		
		public function set type( value:DocumentType ):void
		{
			_type = value;
			
			if( this.document == null
				&& value is DocumentTypeImpl
				&& DocumentTypeImpl( value ).document != null )
			{
				this.document = DocumentTypeImpl( value ).document;
			}
		}
		
		/**
		* 	A default namespace URI for the document.
		*/
		public function get namespaceURI():String
		{
			return _namespaceURI;
		}
		
		public function set namespaceURI( value:String ):void
		{
			_namespaceURI = value;
		}
		
		/**
		* 	The qualified name for the document
		*/
		public function get qualifiedName():String
		{
			if( _qualifiedName == null && type != null )
			{
				return type.name;
			}
			return _qualifiedName;
		}
		
		public function set qualifiedName( value:String ):void
		{
			_qualifiedName = value;
		}
		
		/**
		* 	Creates a document fragment from a source XML
		* 	document.
		* 
		* 	@param source The <code>XML</code> document.
		*/
		public function fragment( source:XML ):void
		{
			_fragmented = true;
			parse( source );
		}
		
		/**
		*	@private
		*/
		override protected function started():void
		{
			if( implementation == null )
			{
				throw new Error(
					"Cannot start a DOM SAX parser without a valid DOM implementation." );
			}
		}
		
		/**
		* 	Handles a document type definition if one has been
		* 	declared for the document.
		*/
		override public function doctype( token:SaxToken ):void
		{
			var definition:DocumentTypeDefinitionImpl = new DocumentTypeDefinitionImpl(
				token.xml );
			qualifiedName = definition.qualifiedName;
			
			//attempt to assign the correct bean document
			//based on the doctype identifier
			this.document = getBeanDocumentFromDtd(
				DOMImplementationImpl( implementation ),
				definition );
				
			this.type = implementation.createDocumentType(
				definition.qualifiedName,
				definition.publicId,
				definition.systemId );
			
			//trace("DomSaxParser::doctype()", "GOT DOC TYPE: ", this.document, qualifiedName, definition );
		}
		
		
		/**
		* 	@private
		*/
		
		//TOOD: re-implement
		internal function getBeanDocumentFromDtd(
			implementation:DOMImplementationImpl,
			definition:DocumentTypeDefinitionImpl ):IBeanDocument
		{
			var document:IBeanDocument = null
			var publicId:String = definition.publicId;
			if( publicId == implementation.document.id )
			{
				document = implementation.document;
			}
			if( document == null )
			{
				
				/*
				for each( var doc:IBeanDocument in implementation.documents )
				{
					if( publicId == doc.id )
					{
						document = doc;
						break;
					}
				}
				*/
			}
			return document;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			//attempt to extract the qualified name and namespace URI
			//if they have not been specified
			if( token.xml != null )
			{
				if( qualifiedName == null
					&& token.xml.name() )
				{
					qualifiedName = token.xml.name().localName;
				}
			
				if( namespaceURI == null )
				{
					namespaceURI = token.xml.@xmlns.length() > 0
						? token.xml.@xmlns.toString() : DEFAULT_NAMESPACE_URI;
				}
			}
			
			super.beginDocument( token );
			
			if( _existing )
			{
				_current = root;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endDocument( token:SaxToken ):void
		{
			_element = Node( root );
			super.endDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function comment( token:SaxToken ):void
		{
			finalizeTextBlock( token );
			createTextBlock( token.type, token.xml.toXMLString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function cdata( token:SaxToken ):void
		{
			finalizeTextBlock( token );
			createTextBlock( SaxToken.CDATA, token.xml.toString() );
		}
		
		override public function text( token:SaxToken ):void
		{			
			if( _textData == null )
			{
				_textStart = current;
				_textData = "";
				_textType = SaxToken.TEXT;
			}
			
			if( _textStart != null && current != _textStart )
			{
				return;
			}
			
			_textData += token.xml.toString();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function shouldTraverseElement( token:SaxToken ):Boolean
		{
			//trace("DomSaxParser::shouldTraverseElement()", _excludeNextElement, token );
			if( _excludeNextElement === true )
			{
				return false;
			}
			return super.shouldTraverseElement( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function instruction( token:SaxToken ):void
		{
			//trace("DomSaxParser::instruction()", "GOT DOM INSTRUCTION BLOCK!?!?!?!?", _textData );
			
			finalizeTextBlock( token );
			
			var document:Document = getCreationDocument();	
			var instruction:ProcessingInstruction = document.createProcessingInstruction(
				token.xml.toXMLString(), token.xml.name().localName );
				
			if( current is Node )
			{
				Node( current ).appendChild( instruction );
			}
			
			if( token.name == EXCLUSION_PROCESSING_INSTRUCTION )
			{
				_excludeNextElement = true;
				_excludeNextElementDepth = depth;
			}
			super.instruction( token );
		}	
		
		private function importAttributes( token:SaxToken ):void
		{
			var document:Document = getCreationDocument();
			if( document != null && current is Element )
			{	
				if( current is Document )
				{
					NodeImpl( current ).namespaceDeclarations =
						token.xml.namespaceDeclarations();
				}
				
				var prefix:String = null;
				var saxattr:SaxAttribute = null;
				var attr:Attr = null;
				for( var i:int = 0;i < token.attributes.length;i++  )
				{
					saxattr = token.attributes[ i ];
					
					//trace("[SAX ATTR] DomSaxParser::importAttributes()", saxattr.name, saxattr.value, saxattr.uri, saxattr.isQualified() );
					
					if( !saxattr.isQualified() )
					{
						attr = document.createAttribute( saxattr.name );
					}else
					{
						attr = document.createAttributeNS( saxattr.uri, saxattr.name )
					}
					attr.value = saxattr.value;
					if( saxattr.isQualified() )
					{
						prefix = token.getNamespacePrefix( saxattr.uri );
						if( prefix != null )
						{
							attr.prefix = prefix;
						}
					}
					
					Element( current ).setAttributeNode( attr );
					
					//assign the attribute data to the element
					current[ NodeImpl( attr ).propertyName ] = AttrImpl( attr ).data;
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginElement( token:SaxToken ):void
		{
			if( _excludeNextElement === true )
			{
				//trace("[EXCLUDE] DomSaxParser::beginElement()", depth, _excludeNextElementDepth );
				
				//ensure we omit child elements of excluded elements
				if( depth > _excludeNextElementDepth )
				{
					return;
				}
				
				_excludeNextElement = false;
				_excludeNextElementDepth = 0;
				return;
			}
			
			finalizeTextBlock( token );
			
			super.beginElement( token );
			
			//trace("[BEGIN ELEMENT] DomSaxParser::beginElement()", token, document, root, current );
			
			//import the list of attributes into the current element
			importAttributes( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endElement( token:SaxToken ):void
		{					
			finalizeTextBlock( token );	
			
			//TODO: 
			//var name:String = null;
			var ancestor:Object = this.parent;
			
			//trace("[DOM END] DomSaxParser::endElement()", root, current, token, this.token, ancestor, depth, current is Node, ancestor is Node );
			
			if( current is Node
			 	&& ancestor is Node
			 	&& current != ancestor )
			{
				//trace("DomSaxParser::endElement()", "[ADDING NODE TO PARENT]" );
				
				NodeImpl( current ).setQualifiedName( token.xml.name() );
				
				//ensure the initial DOM hierarchy is correct
				Node( ancestor ).appendChild(
					Node( current ) );
					
				/*
				trace("DomSaxParser::endElement()", "[END]",
					current, current is EmptyElement, Node( current ).childNodes.length );
				*/
					
				if( current is EmptyElement
					&& current.childNodes.length > 0 )
				{
					throw new Error( "The element '" + current + "' must be empty, contains '"
					 	+ Node( current ).childNodes + "'." );
				}
				
				/*
				trace("DomSaxParser::endElement()", "[END]",
					current, current is TextElement,
					Element( current ).textNodes.length,
					Node( current ).childNodes.length );
				*/
				
				if( current is TextElement )
				{
					var node:Node = null;
					for each( node in Node( current ).childNodes )
					{
						if( !( node is Text ) )
						{
							throw new Error(
								"Found invalid content '"
									+ node + "' for text-only element '" + current + "'." );
						}
					}
				}
			}
			
			super.endElement( token );			 			
		}
		
		/**
		* 	Determines whether an instance is created
		* 	for an element.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Whether an instance should be created for the element.
		*/
		override protected function shouldCreateInstance( token:SaxToken ):Boolean
		{
			//prevents creation of an instance when parsing
			//a partial into an existing element
			if( _existing
				&& depth == 0
				&& ( root as Element ) != null
				&& Element( root ).tagName == token.name )
			{
				return false;
			}
			return true;
		}
		
		/**
		* 	Instatiates an object for an element.
		* 
		* 	When a valid instance is created then the current
		* 	reference is updated to point to the instance.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Either a valid object or null.
		*/
		override protected function getElementInstance( token:SaxToken ):Object
		{
			if( implementation == null )
			{
				throw new Error( "You must associate a DOM implementation when parsing DOM documents." );
			}
			
			var qn:QName = token.xml.name();
			var name:String = qn.localName;		
			
			if( name == null )
			{
				throw new Error( "Cannot retrieve a DOM element with no element name available." );
			}				
			
			var document:Document = getCreationDocument();
			
			var isDocument:Boolean = depth == 0
				&& name == qualifiedName;
			
			var isFragment:Boolean = depth == 0
			 	&& name != qualifiedName;
			
			//create a document for the top-level element
			//when appropriate
			if( document == null )
			{
				if( isDocument )
				{
					//TODO: validate these values: namespaceURI, qualifiedName, type
				
					document = implementation.createDocument(
						namespaceURI, qualifiedName, type );
			
					//default identifier
					NodeImpl( document ).id = namespaceURI;
					_dom = document.documentElement;					
					
					//we need to treat the document as the element itself
					return document;
				}else if( isFragment )
				{
					//create a valid document for fragments that
					//do not have a document as the root element
					
					//we must use the document level identifier not
					//the node name
					document = implementation.createDocument(
						namespaceURI, null, type );	
					
					//update the qualified name so that we can verify	
					qualifiedName = name;
					
					NodeImpl( document ).id = namespaceURI;
					_dom = document.documentElement;
					
					if( _fragmented )
					{
						_root = document.createDocumentFragment();
					}
					
					//fall through so the returned instance is the root element
				}
				
				if( document == null )
				{
					throw new Error( "Cannot parse a DOM document with no document implementation." );
				}
			}
			
			//TODO: add support for namespace usage
			
			//default to creating an element with no namespace
			var element:Element = document.createElement( name );
			
			if( isFragment
				&& _root is Node )
			{
				Node( _root ).appendChild( element );
			}
			
			//trace("[ELEMENT] DomSaxParser::getElementInstance()", element, root );
			
			return element;
		}
		
		private function finalizeTextBlock( token:SaxToken ):void
		{
			if( _textData != null )
			{
				createTextBlock( _textType, _textData );
			}
			
			//
			_textData = null;
			_textType = null;
			_textStart = null;			
		}
		
		private function createTextBlock( type:String, data:String ):CharacterData
		{
			var document:Document = getCreationDocument();
			
			//trace("DomSaxParser::createTextBlock()", document );
			
			//omit text blocks before a DOM document is available
			if( document == null )
			{
				return null;
			}
			
			//trace("DomSaxParser::createTextBlock()", document );
			
			var output:CharacterData = null;
			switch( type )
			{
				case SaxToken.TEXT:
					output = document.createTextNode( data );
					break;
				case SaxToken.COMMENT:
					output = document.createComment( data );
					break;
				case SaxToken.CDATA:
					output = document.createCDATASection( data );
					break;
			}
			
			//trace("DomSaxParser::createTextBlock()", output, current, current is Node );
			
			if( output != null
				&& current is Node )
			{
				Node( current ).appendChild( output );
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		private function getCreationDocument():Document
		{
			if( dom is Document )
			{
				return dom as Document;
			}
			
			var element:Element = ( root as Element );
			if( element != null
				&& element.ownerDocument != null )
			{
				return element.ownerDocument;
			}
			
			return this.root as Document;
		}
		
		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			super.complete();
			
			trace("[DOM SAX PARSER] Completed in",
				( this.time / 1000 ) + " seconds." );
			
			//register the DOM with asquery
			if( !_fragmented && _element is Document )
			{
				//$().onload( dom );
			}
		}
		
		/**
		* 	The element at the root of the document hierarchy.
		*/
		public function get element():Node
		{
			return _element;
		}
		
		/**
		* 	The document used to create the DOM elements.
		*/
		public function get dom():Element
		{
			return _dom;
		}
		
		public function set dom( value:Element ):void
		{
			_dom = value;
		}
	}
}