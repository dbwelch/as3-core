package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.types.ParserAwareXmlLoader;
	
	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.support.xml.BeanXmlParser;	
	
	/**
	*	Encapsulates a collection of XML runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	dynamic public class XmlBeanCollection extends ResourceCollection {
		
		private var _document:IBeanDocument;
		
		/**
		*	Creates a <code>XmlBeanCollection</code> instance.
		*/
		public function XmlBeanCollection()
		{
			super();
		}
		
		/**
		* 	The bean document containing the bean definitions
		* 	for the xml document.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			var loader:ParserAwareXmlLoader = new ParserAwareXmlLoader( request );
			var parser:BeanXmlParser = new BeanXmlParser( this.document );
			loader.parser = parser;
			return loader;
		}
	}
}