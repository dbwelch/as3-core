package com.ffsys.swat.core
{
	import com.ffsys.ioc.*;	
	import com.ffsys.ui.css.*;
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.locale.*;	
	import com.ffsys.swat.configuration.rsls.*;
	
	import com.ffsys.ui.core.IStyleManagerAware;	

	/**
	* 	Represents the default application beans configured before
	* 	the xml configuration is parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.12.2010
	*/
	public class FrameworkBeanConfiguration extends Object
		implements IBeanConfiguration
	{	
		/**
		* 	Creates an <code>FrameworkBeanConfiguration</code> instance.
		*/
		public function FrameworkBeanConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			//trace("FrameworkBeanConfiguration::doWithBeans()", beans );	
			
			var descriptor:IBeanDescriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.BOOTSTRAP_LOADER );
			descriptor.instanceClass = this.bootstrapLoaderClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.MODULE_LOADER );
			descriptor.instanceClass = this.moduleLoaderClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.CONFIGURATION );
			descriptor.instanceClass = this.configurationClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			//configuration type injector
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.CONFIGURATION,
				DefaultBeanIdentifiers.CONFIGURATION,
				IConfigurationAware,
				descriptor ) );
				
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.BEAN_MANAGER );
			descriptor.instanceClass = this.beanManagerClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			
			
			/*
			//bean manager type injector
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.BEAN_MANAGER,
				DefaultBeanIdentifiers.BEAN_MANAGER,
				IBeanManagerAware,
				descriptor ) );
			*/
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.STYLE_MANAGER );
			descriptor.instanceClass = this.styleManagerClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			//bean manager type injector
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.STYLE_MANAGER,
				DefaultBeanIdentifiers.STYLE_MANAGER,
				IStyleManagerAware,
				descriptor ) );
			
			descriptor = new BeanDescriptor(
				DefaultBeanIdentifiers.RESOURCE_MANAGER );
			descriptor.instanceClass = this.resourceManagerClass;
			beans.addBeanDescriptor( descriptor );
			
			//bean manager type injector
			beans.types.push( new BeanTypeInjector(
				DefaultBeanIdentifiers.RESOURCE_MANAGER,
				"resources",
				IResourceManagerAware,
				descriptor ) );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.META );
			descriptor.instanceClass = this.metaClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.PATHS );
			descriptor.instanceClass = this.pathsClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.LOCALES );
			descriptor.instanceClass = this.localesClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.MODULE_LOCALES );
			descriptor.instanceClass = this.moduleLocalesClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.MODULE_CONFIGURATION );
			descriptor.instanceClass = this.moduleConfigurationClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.LOCALE );
			descriptor.instanceClass = this.localeClass;		
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.DEFAULT_LOCALE );
			descriptor.instanceClass = this.defaultLocaleClass;		
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.CURRENT_LOCALE );
			descriptor.instanceClass = this.currentLocaleClass;		
			beans.addBeanDescriptor( descriptor );								
			
			//resource collections
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.RESOURCES );
			descriptor.instanceClass = this.resourcesClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.RESOURCE );
			descriptor.instanceClass = this.resourceClass;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.RSLS );
			descriptor.instanceClass = this.rslsClass;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.RSL );
			descriptor.instanceClass = this.rslClass;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.MESSAGES );
			descriptor.instanceClass = this.messagesClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.ERRORS );
			descriptor.instanceClass = this.errorsClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.SETTINGS );
			descriptor.instanceClass = this.settingsClass;
			beans.addBeanDescriptor( descriptor );							
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.BEANS );
			descriptor.instanceClass = this.beansClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.CSS );
			descriptor.instanceClass = this.cssClass;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.FONTS );
			descriptor.instanceClass = this.fontsClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.XML_RESOURCES );
			descriptor.instanceClass = this.xmlClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.XML_BEANS );
			descriptor.instanceClass = this.xmlBeansClass;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.IMAGES );
			descriptor.instanceClass = this.imagesClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.TEXT );
			descriptor.instanceClass = this.textClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.SOUNDS );
			descriptor.instanceClass = this.soundsClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.COMPONENTS );
			descriptor.instanceClass = this.componentsClass;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.COMPONENT );
			descriptor.instanceClass = this.componentClass;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.VIEW );
			descriptor.instanceClass = this.viewClass;
			beans.addBeanDescriptor( descriptor );			
		}
		
		/**
		* 	The class to use for the bootstrap load process.
		*/
		public function get bootstrapLoaderClass():Class
		{
			return BootstrapLoader;
		}
		
		/**
		* 	The class used to load module data.
		*/
		public function get moduleLoaderClass():Class
		{
			return ModuleLoader;
		}
		
		/**
		* 	The class to use for the application configuration.
		*/
		public function get configurationClass():Class
		{
			return Configuration;
		}
		
		/**
		* 	The class to use for the application bean manager.
		*/
		public function get beanManagerClass():Class
		{
			return BeanManager;
		}		
		
		/**
		* 	The class to use for the application style manager.
		*/
		public function get styleManagerClass():Class
		{
			return StyleManager;
		}
		
		/**
		* 	The class to use for resource managers.
		*/
		public function get resourceManagerClass():Class
		{
			return ResourceManager;
		}
		
		/**
		* 	The class to use for a module configuration.
		*/
		public function get moduleConfigurationClass():Class
		{
			return ModuleConfiguration;
		}		
		
		/**
		* 	The class to use for the application meta data.
		*/
		public function get metaClass():Class
		{
			return ApplicationMeta;
		}
		
		/**
		* 	The class to use for the path configuration elements.
		*/
		public function get pathsClass():Class
		{
			return Paths;
		}
		
		/**
		* 	The class to use for the applicaton locale manager.
		*/
		public function get localesClass():Class
		{
			return LocaleManager;
		}
		
		/**
		* 	The class to use for a module locale manager.
		*/
		public function get moduleLocalesClass():Class
		{
			return ModuleLocaleManager;
		}
		
		/**
		* 	The class to use for a locale definition.
		*/
		public function get localeClass():Class
		{
			return ConfigurationLocale;
		}
		
		/**
		* 	The class to use for the default locale definition.
		*/
		public function get defaultLocaleClass():Class
		{
			return ConfigurationLocale;
		}
		
		/**
		* 	The class to use for a current locale definition.
		*/
		public function get currentLocaleClass():Class
		{
			return ConfigurationLocale;
		}
		
		/**
		* 	The class to use for resource definitions.
		*/
		public function get resourcesClass():Class
		{
			return ResourceDefinitionManager;
		}
		
		/**
		* 	The class to use for an individual resource definition.
		*/
		public function get resourceClass():Class
		{
			return RuntimeResource;
		}

		/**
		* 	The class to use for a collection of
		* 	runtime shared library definitions.
		*/
		public function get rslsClass():Class
		{
			return RslCollection;
		}		
		
		/**
		* 	The class to use for a runtime shared library definition.
		*/
		public function get rslClass():Class
		{
			return RuntimeSharedLibrary;
		}
		
		/**
		* 	The class to use for a collection of message resources.
		*/
		public function get messagesClass():Class
		{
			return PropertiesCollection;
		}
		
		/**
		* 	The class to use for a collection of error message resources.
		*/
		public function get errorsClass():Class
		{
			return PropertiesCollection;
		}
		
		/**
		* 	The class to use for a collection of settings.
		*/
		public function get settingsClass():Class
		{
			return SettingsCollection;
		}
		
		/**
		* 	The class to use for a collection of bean resources.
		*/
		public function get beansClass():Class
		{
			return BeanCollection;
		}
		
		/**
		* 	The class to use for a collection of css resources.
		*/
		public function get cssClass():Class
		{
			return CssCollection;
		}
		
		/**
		* 	The class to use for a collection of font resources.
		*/
		public function get fontsClass():Class
		{
			return FontCollection;
		}	
		
		/**
		* 	The class to use for a collection of xml resources.
		*/
		public function get xmlClass():Class
		{
			return XmlCollection;
		}
		
		/**
		* 	The class to use for a collection of xml bean resources.
		*/
		public function get xmlBeansClass():Class
		{
			return XmlBeanCollection;
		}
		
		/**
		* 	The class to use for a collection of font resources.
		*/
		public function get imagesClass():Class
		{
			return ImageCollection;
		}
		
		/**
		* 	The class to use for a collection of text resources.
		*/
		public function get textClass():Class
		{
			return TextCollection;
		}
		
		/**
		* 	The class to use for a collection of sounds.
		*/
		public function get soundsClass():Class
		{
			return SoundCollection;
		}
		
		/**
		* 	The class to use for a collection of components.
		*/
		public function get componentsClass():Class
		{
			return ComponentCollection;
		}
		
		/**
		* 	The class to use for a component definition.
		*/
		public function get componentClass():Class
		{
			return ComponentResourceCollection;
		}
		
		/**
		* 	The class to use for a view component definition.
		*/
		public function get viewClass():Class
		{
			return ViewComponentCollection;
		}
	}
}