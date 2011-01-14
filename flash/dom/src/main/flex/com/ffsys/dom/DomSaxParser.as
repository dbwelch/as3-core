package com.ffsys.dom
{
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	import asquery.*;

	public class DomSaxParser extends BeanSaxParser
	{
		public static const EXCLUSION_PROCESSING_INSTRUCTION:String = "flash-dom-exclude";
		
		private var _dom:Document;
		
		private var _excludeNextElement:Boolean = false;
		
		/**
		* 	Creates a <code>DomSaxParser</code> instance.
		*/
		public function DomSaxParser()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			if( root == null )
			{
				super.beginDocument( token );
			}
			
			if( root != null
				&& root is Document
				&& _dom == null )
			{
				_current = root;
				_dom = Document( this.root );
				importAttributes( token );
			}
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
			//trace("[GOT TEXT LEAF NODE] DomSaxParser::text()", token );
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
					trace("[SAX ATTR] DomSaxParser::beginElement()", saxattr, saxattr.name, saxattr.isQualified() );
			
					if( !saxattr.isQualified() )
					{
						Element( current ).setAttribute( saxattr.name, saxattr.value );
					}else
					{
						Element( current ).setAttributeNS( saxattr.uri, saxattr.name, saxattr.value );
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
			
			super.beginElement( token );
			
			var document:Document = this.root as Document;
			
			trace("DomSaxParser::beginElement()", document, current );
			
			if( document != null
				&& current is Node )
			{
				Node( current ).setOwnerDocument( document );
			}
			
			/*
			if( current is IDomXmlAware )
			{
				IDomXmlAware( current ).xml = token.xml.copy();
			}
			*/
			
			importAttributes( token );
			
			//trace("[DOM SAX PARSER BEGIN ELEMENT] DomSaxParser::beginElement() root/parent/current: " , root, parent, current);			
			
			var ancestor:Object = this.parent;
			
			if( current is Node
				&& ancestor != null
			 	&& ancestor is Node )
			{
				//ensure the initial DOM hierarchy is correct
				Node( ancestor ).appendChild(
					Node( current ) );
				
				//TODO: property name conversion hyphens to camel case
				var name:String = token.name;
					
				//also assign a reference by property name
				ancestor[ name ] = current;
			}
			
			//TODO: instantiate and assign visual composite where applicable
			
			//TODO: allow a document to do this when the createElement() method is called
			if( current is Element && document != null )
			{
				document.registerElement( Element( current ) );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endElement( token:SaxToken ):void
		{		
			super.endElement( token );
			//trace("[DOM SAX PARSER END ELEMENT] DomSaxParser::endElement() root/parent/current: " , root, parent, current);
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