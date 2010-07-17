package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Describes the contract for implementations that represent
	*	a collection of runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	public interface IRuntimeResourceCollection extends IDeserializeProperty {
		
		/**
		*	Gets the loader used to load runtime resources for this collection.
		*	
		*	@param request The request for the load operation.
		*	
		*	@return The loader used to load the runtime resource.
		*/
		function getLoader( request:URLRequest ):ILoader;
		
		/**
		* 	Gets the loader queue used to load the runtime resources.
		* 
		* 	@return The runtime resource loader queue.
		*/
		function getLoaderQueue():ILoaderQueue;
	}
}