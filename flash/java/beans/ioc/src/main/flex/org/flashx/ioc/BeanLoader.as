package org.flashx.ioc {
	
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import org.flashx.io.loaders.core.ILoadOptions;
	import org.flashx.io.loaders.types.TextLoader;
	
	/**
	*	Loads a single bean document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class BeanLoader extends TextLoader {
		
		private var _document:IBeanDocument;
		private var _parser:IBeanParser;
		
		/**
		*	Creates a <code>BeanLoader</code> instance.
		*	
		*	@param request The url request.
		*	@param options The load options.
		*/
		public function BeanLoader(
			request:URLRequest = null,
			options:ILoadOptions = null	)
		{
			super( request, options );
		}
		
		/**
		* 	Gets the parser used to parse the document beans.
		*/
		public function get parser():IBeanParser
		{
			return _parser;
		}
		
		public function set parser( value:IBeanParser ):void
		{
			_parser = value;
		}
		
		/**
		*	The bean document to parse the text file into.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( document:IBeanDocument ):void
		{
			_document = document;
		}
		
		/**
		* 	Gets a parser for the document assigned to this loader.
		* 
		* 	If a custom <code>parser</code> has been assigned it will be
		* 	used otherwise a text parser will be created by default.
		* 
		* 	@param document The bean document to assign to the parser.
		* 
		* 	@return The bean parser this bean loader will use.
		*/
		public function getParser( document:IBeanDocument ):IBeanParser
		{
			if( !_parser )
			{
				_parser = new BeanTextParser();
			}
			_parser.document = document;
			return _parser;
		}
		
		/**
		* 	Determines wheher this loader should parse the loaded text.
		* 
		* 	@return A boolean indicating whether this loader should
		* 	parse the loaded text data. 
		*/
		override protected function shouldParseText():Boolean
		{
			return true;
		}
		
		/**
		*	Parses the beans document text into a bean document.
		* 
		* 	@param text The bean document text.
		* 
		* 	@return The bean document.
		*/
		override protected function parse( text:String ):Object
		{
			var beans:IBeanDocument = this.document != null ? this.document : BeanDocumentFactory.create();
			var parser:IBeanParser = getParser( beans );
			parser.parse( text );
			return beans;
		}
	}
}