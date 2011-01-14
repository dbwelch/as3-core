package com.ffsys.dom
{
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	import asquery.*;
	
	
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
		
		private var _implementation:DOMImplementation;
		private var _namespaceURI:String;
		private var _qualifiedName:String;
		private var _doctype:DocumentType;
		
		/**
		* 	Creates a <code>DomSaxParser</code> instance.
		*/
		public function DomSaxParser(
			implementation:DOMImplementation,
			doctype:DocumentType )
		{
			super();
			this.implementation = implementation;
			this.doctype = doctype;						
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
		public function get doctype():DocumentType
		{
			return _doctype;
		}
		
		public function set doctype( value:DocumentType ):void
		{
			_doctype = value;
			
			if( this.document == null
				&& value != null
				&& value.elements != null )
			{
				this.document = value.elements;
			}
		}		
		
		/**
		* 	The namespace URI for the document.
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
			//trace("DomSaxParser::fragment()", _fragmented, source );
			parse( source );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			//var qualifiedName:String = null;
			//var namespaceURI:String = null;
			
			//extract the qualified name and namespace URI
			//if they have not been specified
			if( token.xml != null )
			{
				if( qualifiedName == null && token.xml.name() )
				{
					qualifiedName = token.xml.name().localName;
				}
			
				if( namespaceURI == null )
				{
					namespaceURI = token.xml.@xmlns.length() > 0
						? token.xml.@xmlns.toString() : DEFAULT_NAMESPACE_URI;
				}
			}
			
			//if( root == null )
			//{
				super.beginDocument( token );
			//}
			
			/*
			if( root != null
				&& root is Document
				&& _dom == null )
			{
				_current = root;
				_dom = Document( this.root );
				importAttributes( token );
			}
			*/
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endDocument( token:SaxToken ):void
		{
			_element = Node( root );
			
			//trace("DomSaxParser::endDocument()", _dom, root, _element );
			
			super.endDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function comment( token:SaxToken ):void
		{
			if( _textData != null )
			{
				createTextBlock( _textType, _textData );				
				//trace("[CREATE TEXT BLOCK AT END] DomSaxParser::endElement()", _textData );
				
				//
				_textData = null;
				_textType = null;
				_textStart = null;
			}			
			
			createTextBlock( token.type, token.xml.toXMLString() );
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
			
			//trace("[CONCATENTATING TEXT] DomSaxParser::text()", current, token.xml.toXMLString() );
			
			_textData += token.xml.toString();
			
			//var text:Text = Text( getTextInstance( token, token.xml.toString() ) );
			
			//trace("[GOT TEXT LEAF NODE INSTANCE] DomSaxParser::text()", current, text, text.data, text.xml.toXMLString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function shouldTraverseElement( token:SaxToken ):Boolean
		{
			
			if( _excludeNextElement === true
				|| token.type == SaxToken.COMMENT )
			{
				//trace("[SKIPPING EXCLUDED ELEMENT] DomSaxParser::beginElement()", token, token.target );
				return false;
			}
			
			return super.shouldTraverseElement( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithProcessingInstruction( token:SaxToken ):void
		{
			//trace("[PROCESSING-INSTRUCTION] SaxParser::doWithProcessingInstruction()", token.name, token.type );
			if( token.name == EXCLUSION_PROCESSING_INSTRUCTION )
			{
				//trace("[PROCESSING-INSTRUCTION - FOUND HTML ONLY ELEMENT] SaxParser::doWithProcessingInstruction()", token.name, token.type );	
				_excludeNextElement = true;
			}
			super.doWithProcessingInstruction( token );
		}	
		
		private function importAttributes( token:SaxToken ):void
		{
			var document:Document = getCreationDocument();
			
			trace("DomSaxParser::importAttributes()", document, current );
			
			if( document != null && current is Element )
			{			
				var saxattr:SaxAttribute = null;
				for each( saxattr in token.attributes )
				{
					trace("[SAX ATTR] DomSaxParser::importAttributes()", saxattr, saxattr.name, saxattr.isQualified() );
					if( !saxattr.isQualified() )
					{
						Element( current ).setAttribute(
							saxattr.name, saxattr.value );
					}else
					{
						Element( current ).setAttributeNS(
							saxattr.uri, saxattr.name, saxattr.value );
					}
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
				//trace("[SKIPPING EXCLUDED ELEMENT] DomSaxParser::beginElement()", token );
				_excludeNextElement = false;
				return;
			}
			
			if( _textData != null )
			{
				//trace("[CREATE TEXT BLOCK AT START] DomSaxParser::beginElement()", _textData );
				createTextBlock( _textType, _textData );
			}
			
			//
			_textData = null;
			_textType = null;
			_textStart = null;
			
			super.beginElement( token );
			
			var document:Document = getCreationDocument();
			var name:String = null;
			
			trace("[BEGIN ELEMENT] DomSaxParser::beginElement()", document, root, current );
			
			//import the list of attributes into the current element
			importAttributes( token );
			
			//TODO: 
			var ancestor:Object = this.parent;
			
			if( current is Node
				&& ancestor != null
			 	&& ancestor is Node )
			{
				//ensure the initial DOM hierarchy is correct
				Node( ancestor ).appendChild(
					Node( current ) );
				
				//TODO: property name conversion hyphens to camel case
				name = token.name;
				
				trace("[ASSIGNING] DomSaxParser::beginElement() ancestor/name/current:", ancestor, name, current, root );
					
				//also assign a reference by property name
				ancestor[ name ] = current;
			}
		}
		
		//_textData = null;
		
		/**
		* 	@inheritDoc
		*/
		override public function endElement( token:SaxToken ):void
		{					
			if( _textData != null )
			{
				createTextBlock( _textType, _textData );				
				//trace("[CREATE TEXT BLOCK AT END] DomSaxParser::endElement()", _textData );
			}
			
			//
			_textData = null;
			_textType = null;
			_textStart = null;
			
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
				&& name == DomIdentifiers.DOCUMENT;	
			
			var isFragment:Boolean = depth == 0
			 	&& name != DomIdentifiers.DOCUMENT;	
			
			//create a document for the top-level element
			//when appropriate
			if( document == null )
			{
				
				if( isDocument )
				{
					//TODO: validate these values: namespaceURI, qualifiedName, doctype
				
					document = implementation.createDocument(
						namespaceURI, qualifiedName, doctype );
					
					trace("[CREATE ROOT DOCUMENT INSTANCE] DomSaxParser::getElementInstance()", document );
			
					//default identifier
					document.id = namespaceURI;
					_dom = document;					
					
					//we need to treat the document as the element itself
					return document;
				}else if( isFragment )
				{
					//create a valid document for fragments that
					//do not have a document as the root element
					
					//we must use the document level identifier not
					//the node name
					document = implementation.createDocument(
						namespaceURI, DomIdentifiers.DOCUMENT, doctype );	
					
					//update the qualified name so that we can verify	
					qualifiedName = name;
					
					document.id = namespaceURI;
					_dom = document;
					
					if( _fragmented )
					{
						_root = document.createDocumentFragment();
					}
					
					trace("[CREATE DOM FRAGMENT] DomSaxParser::getElementInstance()!!!!!!!!!!!!!!!!!!!!!!!!!!", dom, _fragmented, _root );
					
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
			
			//trace("DomSaxParser::getElementInstance()", element, root );
			
			return element;
		}
		
		private function createTextBlock( type:String, data:String ):CharacterData
		{
			var document:Document = getCreationDocument();
			var output:CharacterData = null;
			
			//trace("DomSaxParser::getTextInstance()", document );
			
			switch( type )
			{
				case SaxToken.TEXT:
					output = document.createTextNode( data );
					break;
				case SaxToken.COMMENT:
					output = document.createComment( data );
					break;
				//TODO: 
				case "cdata":
					output = document.createCDATASection( data );
					break;
			}
			
			trace("DomSaxParser::createTextBlock()", output, current );
			
			if( output != null
				&& current is Node )
			{
				//trace("[ADDING TEXT CHILD NODE] DomSaxParser::createTextBlock()", current, output );
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
			return this.root as Document;
		}
		
		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			//register the DOM with asquery
			
			if( !_fragmented && _element is Document )
			{
				$().onload( dom );
			}
			//trace("[DOM COMPLETE] DomSaxParser::complete()", ActionscriptQuery.doms );
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