package com.ffsys.swat.core
{
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.io.loaders.resources.IResourceList;	
	
	/**
	* 	Describes the contract for implementations that
	* 	are responsible for configuring the application
	* 	beans once the application has finished the bootstrap
	* 	process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IBeanConfiguration
	{
		/**
		* 	Configures the default injector beans for the application.
		* 
		* 	Injector beans are objects that have already been instantiated and
		* 	should be made available to bean documents.
		* 
		* 	@param beans The application beans document.
		* 	@param configuration The application configuration.
		* 	@param resources A global resource list.
		*/
		function doWithBeans(
			beans:IBeanDocument,
			configuration:IConfiguration,
			resources:IResourceList = null ):void;
	}
}