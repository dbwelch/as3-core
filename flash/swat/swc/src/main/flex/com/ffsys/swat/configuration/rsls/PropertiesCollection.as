package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.PropertiesLoader;
	
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
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new PropertiesLoader( request );
		}
	}
}