package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import org.flashx.ioc.BeanLoader;
	import org.flashx.ioc.IBeanDocument;	
	import org.flashx.io.loaders.core.ILoaderElement;
	
	/**
	*	Encapsulates a collection of bean documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2010
	*/
	dynamic public class BeanCollection extends ResourceCollection {
		
		private var _document:IBeanDocument;	
		
		/**
		*	Creates a <code>BeanCollection</code> instance.
		*/
		public function BeanCollection()
		{
			super();
		}
		
		/**
		* 	The bean document the beans should be loaded into.
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
			var loader:BeanLoader = new BeanLoader( request );
			loader.document = this.document;
			return loader;
		}
	}
}