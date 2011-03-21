package org.flashx.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.io.xml.IDeserializeProperty;
	
	import org.flashx.swat.configuration.IPaths;	
	import org.flashx.swat.configuration.locale.IConfigurationLocale;	
	
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
	public interface IResourceCollection
		extends	IResourceDefinitionElement,
				IDeserializeProperty {
		
		/**
		* 	The number of resources in this collection.
		*/
		function get length():uint;
		
		/**
		*	Gets the loader used to load runtime resources for this collection.
		*	
		*	@param request The request for the load operation.
		*	
		*	@return The loader used to load the runtime resource.
		*/
		function getLoader( request:URLRequest ):ILoaderElement;
		
		/**
		* 	Gets the loader queue used to load the runtime resources.
		* 
		* 	@param paths The paths implementation to use when
		* 	building translated paths.
		* 	@param locale A locale that indicates paths should
		* 	be built in a locale specific manner.
		* 
		* 	@return The runtime resource loader queue.
		*/
		function getLoaderQueue(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):ILoaderQueue;
	}
}