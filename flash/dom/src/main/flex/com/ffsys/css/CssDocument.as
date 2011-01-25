package com.ffsys.css
{
	import com.ffsys.dom.*;	
	import com.ffsys.ioc.IBeanDocument;
	
	/**
	* 	Responsible for parsing css documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class CssDocument extends Document
	{	
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>CssDocument</code> instance.
		*/
		public function CssDocument()
		{
			super();
		}
		
		/**
		* 	Adds a style rule to this document.
		* 
		* 	@param rule The style rule.
		* 
		* 	@return Whether the style rule was added.
		*/
		public function addStyleRule( rule:StyleRule ):Boolean
		{
			appendChild( rule );
			
			trace("CssDocument::addStyleRule()", rule );
			
			//TODO
			return true;
		}
		
		/**
		* 	Parses the source object as css.
		* 
		* 	@param source The source object to parse.
		*/
		public function parse( source:Object ):void
		{
			if( !( source is XML ) )
			{
				source = new XML( "<css>" + source + "</css>" );
			}
			
			var parser:CssSaxParser = new CssSaxParser();
			
			/*
			trace("[CSS PARSE] CssDocument::parse()",
				( source as XML ).toXMLString(), ( source as XML ).children().length() );
			*/
			
			parser.css = this;
			parser.document = this.document;
			parser.parse( source as XML );
		}
	}
}