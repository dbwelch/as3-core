package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoaderElement;
	import com.ffsys.ui.css.CssLoader;
	import com.ffsys.ui.css.ICssStyleSheet;	
	
	/**
	*	Encapsulates a collection of CSS runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.10.2010
	*/
	dynamic public class CssCollection extends ResourceCollection {
		
		private var _stylesheet:ICssStyleSheet;
		
		/**
		*	Creates a <code>CssCollection</code> instance.
		*/
		public function CssCollection()
		{
			super();
		}
		
		/**
		* 	A stylesheet to use when loading css documents.
		*/
		public function get stylesheet():ICssStyleSheet
		{
			return _stylesheet;
		}
		
		public function set stylesheet( value:ICssStyleSheet ):void
		{
			_stylesheet = value;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			var loader:CssLoader = new CssLoader( request );
			loader.css = this.stylesheet;
			return loader;
		}
	}
}