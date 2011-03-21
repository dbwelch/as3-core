package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.types.TextLoader;
	
	/**
	*	Encapsulates a collection of text resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	dynamic public class TextCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>TextCollection</code> instance.
		*/
		public function TextCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new TextLoader( request );
		}
	}
}