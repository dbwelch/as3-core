package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.XmlLoader;
	
	/**
	*	Encapsulates a collection of XML runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.10.2010
	*/
	dynamic public class XmlCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>XmlCollection</code> instance.
		*/
		public function XmlCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new XmlLoader( request );
		}
	}
}