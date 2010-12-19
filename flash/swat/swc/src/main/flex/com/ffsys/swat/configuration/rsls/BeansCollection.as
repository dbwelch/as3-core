package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.ioc.BeanLoader;
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Encapsulates a collection of bean documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2010
	*/
	dynamic public class BeansCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>BeansCollection</code> instance.
		*/
		public function BeansCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new BeanLoader( request );
		}
	}
}