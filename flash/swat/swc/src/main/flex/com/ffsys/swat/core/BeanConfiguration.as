package com.ffsys.swat.core
{
	import com.ffsys.ioc.*;
	import com.ffsys.swat.configuration.DefaultBeanIdentifiers;
	import com.ffsys.swat.configuration.IConfiguration;
		
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
		* 	@inheritDoc
		*/
		public function doWithBeans(
			beans:IBeanDocument,
			configuration:IConfiguration,
			resources:IResourceManager ):void
		{
			if( beans == null )
			{
				throw new Error( "Cannot modify a null bean document." );
			}
			
			//allow the main bean document to access all the beans
			//in the style sheet bean document
			beans.xrefs.push( configuration.stylesheet );

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
			var localeBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.LOCALE, configuration.locales.current );
			var resourcesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.RESOURCES, resources );
		
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
			//global resources
			beans.addBeanDescriptor( resourcesBean );
		
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
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.LOCALE,
				DefaultBeanIdentifiers.LOCALE,
				ILocaleAware,
				localeBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.RESOURCES,
				DefaultBeanIdentifiers.RESOURCES,
				IResourcesAware,
				resourcesBean ) );							
		}		
	}
}