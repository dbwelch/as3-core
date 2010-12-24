package com.ffsys.swat.core
{
	import com.ffsys.ioc.*;	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.locale.*;	
	import com.ffsys.swat.configuration.rsls.*;

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
	public class ApplicationBeanConfiguration extends Object
		implements IBeanConfiguration
	{
		
		/**
		* 	Creates an <code>ApplicationBeanConfiguration</code> instance.
		*/
		public function ApplicationBeanConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			trace("ApplicationBeanConfiguration::doWithBeans()", beans );
			
			var descriptor:IBeanDescriptor = new BeanDescriptor( 
				DefaultBeanIdentifiers.CONFIGURATION );
			descriptor.instanceClass = this.configurationClass;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
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
		}
		
		/**
		* 	The class to use for the application configuration.
		*/
		public function get configurationClass():Class
		{
			return Configuration;
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
		* 	The class to use for the locale manager.
		*/
		public function get localesClass():Class
		{
			return LocaleManager;
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
	}
}