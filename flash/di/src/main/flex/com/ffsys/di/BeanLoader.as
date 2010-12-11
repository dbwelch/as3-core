package com.ffsys.di {
	
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.types.TextLoader;
	
	/**
	*	Responsible for loading css files that can
	*	declare external file dependencies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class BeanLoader extends TextLoader {
		
		private var _document:IBeanDocument;
		
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
		*	@inheritDoc
		*/
		override protected function parse( text:String ):Object
		{
			var beans:IBeanDocument = document ? document : BeanDocumentFactory.create();
			
			//TODO: implement CSS/XML switching
			
			var parser:IBeanParser = new BeanTextParser( beans );
			parser.parse( text );
			return beans;
		}
	}
}