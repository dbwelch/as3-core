package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.types.ImageLoader;	
	
	/**
	*	Encapsulates a collection of image files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	dynamic public class ImageCollection extends ResourceCollection {
		
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
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new ImageLoader( request );
		}
	}
}