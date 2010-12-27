package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.ioc.BeanLoader;
	import com.ffsys.io.loaders.core.ILoaderElement;
	
	/**
	*	Encapsulates a collection of bean documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2010
	*/
	dynamic public class BeanCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>BeanCollection</code> instance.
		*/
		public function BeanCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new BeanLoader( request );
		}
	}
}