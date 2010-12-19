package com.ffsys.swat.core
{
	import com.ffsys.ioc.*;
	import com.ffsys.swat.configuration.DefaultBeanIdentifiers;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.io.loaders.resources.IResourceList;
		
	/**
	* 	Encpausulates the default bean configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public class BeanConfiguration extends Object
		implements IBeanConfiguration
	{
		
		/**
		* 	Creates a <code>BeanConfiguration</code> instance.
		*/
		public function BeanConfiguration()
		{
			super();
		}
		
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
		public function doWithBeans(
			beans:IBeanDocument,
			configuration:IConfiguration,
			resources:IResourceList = null ):void
		{
			if( beans == null )
			{
				throw new Error( "Cannot modify a null bean document." );
			}
			
			//allow the main bean document to access all the beans
			//in the style sheet bean document
			beans.xrefs.push( configuration.locales.stylesheet );

			var configurationBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.CONFIGURATION, configuration )
			var flashvarsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.FLASH_VARIABLES, configuration.flashvars );
			var localesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.LOCALES, configuration.locales );
			var messagesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MESSAGES, configuration.locales.messages );
			var pathsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PATHS, configuration.paths );
		
			//application configuration
			beans.addBeanDescriptor( configurationBean );
			//flash variables
			beans.addBeanDescriptor( flashvarsBean );
			//locales manager
			beans.addBeanDescriptor( localesBean );	
			//application messages
			beans.addBeanDescriptor( messagesBean );
			//resource paths
			beans.addBeanDescriptor( pathsBean );	
		
			//set up the generic type injectors
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.CONFIGURATION,
				DefaultBeanIdentifiers.CONFIGURATION,
				IConfigurationAware,
				configurationBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.FLASH_VARIABLES,
				DefaultBeanIdentifiers.FLASH_VARIABLES,
				IFlashVariablesAware,
				flashvarsBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.LOCALES,
				DefaultBeanIdentifiers.LOCALES,
				ILocalesAware,
				localesBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.MESSAGES,
				DefaultBeanIdentifiers.MESSAGES,
				IMessagesAware,
				messagesBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.PATHS,
				DefaultBeanIdentifiers.PATHS,
				IPathsAware,
				pathsBean ) );
		}		
	}
}