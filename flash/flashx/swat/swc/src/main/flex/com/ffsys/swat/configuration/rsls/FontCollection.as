package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoaderElement;
	import com.ffsys.io.loaders.types.FontLoader;	
	
	/**
	*	Encapsulates a collection of font files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	dynamic public class FontCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>FontCollection</code> instance.
		*/
		public function FontCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new FontLoader( request );
		}
	}
}