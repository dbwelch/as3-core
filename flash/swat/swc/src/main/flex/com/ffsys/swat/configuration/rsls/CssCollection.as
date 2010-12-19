package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.ui.css.CssLoader;
	
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
		
		/**
		*	Creates a <code>CssCollection</code> instance.
		*/
		public function CssCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new CssLoader( request );
		}
	}
}