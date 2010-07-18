package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.ILoader;
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
	dynamic public class FontCollection extends RuntimeResourceCollection {
		
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
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new FontLoader( request );
		}
	}
}