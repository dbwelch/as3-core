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
		
		private var _dom:Document;
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
		* 	The implementation used to create the document
		* 	when parsing entire documents.
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
			if( root == null )
			{
				super.endDocument( token );
			}
		}
		
		override public function text( token:SaxToken ):void
		{
			if( _textData == null )
			{
				_textStart = current;
				_textData = "";
				_textType = "text";
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
			if( _excludeNextElement === true )
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
			var document:Document = this.root as Document;
			if( document != null && current is Element )
			{			
				var saxattr:SaxAttribute = null;
				for each( saxattr in token.attributes )
				{
					//trace("[SAX ATTR] DomSaxParser::importAttributes()", saxattr, saxattr.name, saxattr.isQualified() );
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
			
			var document:Document = this.root as Document;
			var name:String = null;
			
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
				
				trace("[ASSIGNING] DomSaxParser::beginElement() ancestor/name/current:", ancestor, name, current );
					
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
			
			var document:Document = this.root as Document;			
			
			//create a document for the top-level element
			//when appropriate
			if( document == null
				&& depth == 0
				&& name == DomIdentifiers.DOCUMENT )
			{
				//TODO: validate these values: namespaceURI, qualifiedName, doctype
				
				document = implementation.createDocument(
					namespaceURI, qualifiedName, doctype );
				
				//default identifier
				document.id = namespaceURI;
				
				_dom = document;
					
				trace("[CREATE ROOT DOCUMENT INSTANCE] DomSaxParser::getElementInstance()", document );
					
				return document;
			}
			
			if( document == null )
			{
				throw new Error( "Cannot parse a DOM document with no document implementation." );
			}
			
			//TODO: add support for namespace usage
			
			return document.createElement( name );
		}
		
		private function createTextBlock( type:String, data:String ):CharacterData
		{
			var document:Document = this.root as Document;			
			var output:CharacterData = null;
			
			//trace("DomSaxParser::getTextInstance()", type, data );
			
			switch( type )
			{
				case "text":
					output = document.createTextNode( data );
					break;
				case "comment":
					output = document.createComment( data );
					break;
				case "cdata":
					output = document.createCDATASection( data );
					break;
			}
			
			//trace("DomSaxParser::createTextBlock()", output, current );
			
			if( output != null
				&& current is Node )
			{
				//trace("[ADDING TEXT CHILD NODE] DomSaxParser::createTextBlock()", current, output );
				Node( current ).appendChild( output );
			}
			
			return output;
		}		
		
		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			//register the DOM with asquery
			$().onload( dom );
			//trace("[DOM COMPLETE] DomSaxParser::complete()", ActionscriptQuery.doms );
		}
		
		/**
		* 	The document used to create the DOM.
		*/
		public function get dom():Document
		{
			return _dom;
		}
		
		public function set dom( value:Document ):void
		{
			_dom = value;
		}
	}
}