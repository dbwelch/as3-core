package com.ffsys.css
{
	import com.ffsys.dom.core.*;		
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
		/**
		* 	Creates a <code>CssDocument</code> instance.
		*/
		public function CssDocument()
		{
			super();
		}
		
		/**
		* 	Retrieves all at rule declarations.
		*/
		public function get atRules():Vector.<AtRule>
		{
			var output:Vector.<AtRule> = new Vector.<AtRule>();
			var node:Node = null;
			for each( node in childNodes )
			{
				if( node is AtRule )
				{
					output.push( AtRule( node ) );
				}
			}
			return output;
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