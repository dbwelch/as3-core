package com.ffsys.dom
{
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	import asquery.$;	

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
			
			trace("[DOM SAX PARSER BEGIN ELEMENT] DomSaxParser::beginElement() root/current/parent: ", root, current, parent );			
			
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
			
			if( current is Element )
			{
				document.registerElement( Element( current ) );
			}
		}
		
		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			_dom = Document( this.root );
		
			//TODO: move this to an initialization routine
			//DOM implementations that we are aware of
			Object( $ ).doms = new Vector.<Document>();
			
			Object( $ ).doms.push( _dom );
			
			trace("[DOM COMPLETE] DomSaxParser::complete()", $, Object( $ ).doms );
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