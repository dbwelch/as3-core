package com.ffsys.dom
{
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	import asquery.ActionscriptQuery;

	public class DomSaxParser extends BeanSaxParser
	{
		private var _dom:Document;
		
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
		override public function beginElement( token:SaxToken ):void
		{
			super.beginElement( token );
			
			var document:Document = Document( this.root );
			
			if( current is IDomXmlAware )
			{
				IDomXmlAware( current ).xml = token.xml;
			}
			
			trace("[DOM SAX PARSER BEGIN ELEMENT] DomSaxParser::beginElement() root/parent/current: " , root, parent, current);			
			
			var ancestor:Object = this.parent;
			
			if( current is Node
				&& ancestor != null
			 	&& ancestor is Node )
			{
				//ensure the initial DOM hierarchy is correct
				Node( ancestor ).appendChild(
					Node( current ) );
				
				//TODO: group elements of the same type
				
				//TODO: property name conversion hyphens to camel case
				var name:String = token.name;
					
				//also assign a reference by property name
				ancestor[ name ] = current;
			}
			
			//TODO: instantiate and assign visual composite where applicable
			
			//TODO: allow a document to do this when the createElement() method is called
			if( current is Element )
			{
				document.registerElement( Element( current ) );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endElement( token:SaxToken ):void
		{		
			trace("[DOM SAX PARSER END ELEMENT] DomSaxParser::endElement() root/parent/current: " , root, parent, current);
			super.endElement( token );
		}		
		
		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			_dom = Document( this.root );
		
			ActionscriptQuery.doms.push( _dom );
			
			trace("[DOM COMPLETE] DomSaxParser::complete()", ActionscriptQuery.doms );
		}
		
		/**
		* 	The document used to create the DOM.
		*/
		public function get dom():Document
		{
			return _dom;
		}
	}
}