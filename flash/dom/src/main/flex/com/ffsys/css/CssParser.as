package com.ffsys.css
{
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
	public class CssParser extends Object
	{	
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>CssParser</code> instance.
		*/
		public function CssParser()
		{
			super();
		}
		
		/**
		* 	The bean document used when parsing 
		* 	css source.
		*/
		public function get document():IBeanDocument
		{
			if( _document == null )
			{
				_document = new CssBeanDocument();
			}
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
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
			parser.document = this.document;
			parser.parse( source as XML );
		}
	}
}