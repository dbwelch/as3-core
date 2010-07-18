package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.ImageLoader;	
	
	/**
	*	Encapsulates a collection of image files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	dynamic public class ImageCollection extends RuntimeResourceCollection {
		
		/**
		*	Creates a <code>ImageCollection</code> instance.
		*/
		public function ImageCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new ImageLoader( request );
		}
	}
}