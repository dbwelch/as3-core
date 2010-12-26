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
			
			var flashvarsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.FLASH_VARIABLES, configuration.flashvars );
			
			var localesBean:IBeanDescriptor = beans.getBeanDescriptor(
				DefaultBeanIdentifiers.LOCALES, true );
			
			trace("BeanConfiguration::init()", beans.xrefs.length, localesBean );
				
			var messagesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MESSAGES, configuration.resources.messages );
			var errorsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.ERRORS, configuration.resources.errors );
			var settingsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.SETTINGS, configuration.resources.settings );
			var pathsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PATHS, configuration.paths );
			var localeBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.LOCALE, configuration.locales.current );
			var resourcesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.RESOURCES, resources );
			
			/*
			//flash variables
			beans.addBeanDescriptor( flashvarsBean );
			*/
			
			//locales manager
			//beans.addBeanDescriptor( localesBean );	
			
			//flash variables
			beans.addBeanDescriptor( flashvarsBean );
			//application messages
			beans.addBeanDescriptor( messagesBean );
			//application error messages
			beans.addBeanDescriptor( errorsBean );
			//application settings
			beans.addBeanDescriptor( settingsBean );
			//resource paths
			beans.addBeanDescriptor( pathsBean );
			//global resources
			beans.addBeanDescriptor( resourcesBean );
		
			//set up the generic type injectors
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
				DefaultBeanIdentifiers.ERRORS,
				DefaultBeanIdentifiers.ERRORS,
				IErrorMessagesAware,
				errorsBean ) );
				
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.SETTINGS,
				DefaultBeanIdentifiers.SETTINGS,
				ISettingsAware,
				settingsBean ) );
				
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