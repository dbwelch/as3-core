package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.types.PropertiesLoader;
	
	/**
	*	Encapsulates a collection of property files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	dynamic public class PropertiesCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>PropertiesCollection</code> instance.
		*/
		public function PropertiesCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new PropertiesLoader( request );
		}
	}
}