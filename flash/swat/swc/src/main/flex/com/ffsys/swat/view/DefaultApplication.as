package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.io.xml.Deserializer;
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.ioc.*;
	import com.ffsys.ioc.support.xml.*;
	
	import com.ffsys.swat.core.*;
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.events.ConfigurationEvent;
	import com.ffsys.swat.events.RslEvent;	
	
	/**
	*	Abstract super class for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class DefaultApplication extends Sprite
		implements IApplication {
		
		private var _framework:IBeanDocument;
		private var _preloader:IBootstrapLoader;
		private var _flashvars:IFlashVariables;
		private var _configuration:IConfiguration;
		
		/**
		*	Creates a <code>DefaultApplication</code> instance.
		*/
		public function DefaultApplication()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, created );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get preloader():IBootstrapLoader
		{
			return _preloader;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}
		
		/**
		* 	Allows derived implementations to modify the
		* 	framework beans document.
		* 
		* 	@param framework The framework beans document.
		*/
		protected function doWithFrameworkBeans(
			framework:IBeanDocument ):void
		{
			//
		}
		
		/**
		* 	Allows derived implementations to modify the
		* 	default framework bean configuration implementation.
		* 
		* 	@return The framework bean configuration implementation.
		*/
		protected function getFrameworkBeanConfiguration():IBeanConfiguration
		{
			return new FrameworkBeanConfiguration();
		}
		
		/**
		*	@inheritDoc
		*/
		internal function setFlashVariables(
			flashvars:IFlashVariables ):void
		{
			if( !_flashvars )
			{
				_flashvars = flashvars;

				if( !_preloader )
				{
					//create default framework beans
					var beans:IBeanDocument = this.framework;
					var configuration:IBeanConfiguration = getFrameworkBeanConfiguration();
					configuration.doWithBeans( beans );	
					
					//set up the injected flash variables bean
					var descriptor:IBeanDescriptor = new InjectedBeanDescriptor(
						DefaultBeanIdentifiers.FLASH_VARIABLES, _flashvars );
					this.framework.addBeanDescriptor( descriptor );

					//configuration type injector
					this.framework.types.push( new BeanTypeInjector(
						DefaultBeanIdentifiers.FLASH_VARIABLES,
						DefaultBeanIdentifiers.FLASH_VARIABLES,
						IFlashVariablesAware,
						descriptor ) );
					
					var parser:IParser = getConfigurationParser( this.framework );
					
					/*
					_preloader = new BootstrapLoader(
						parser,
						_flashvars );
					*/
					
					_preloader = this.framework.getBean(
						DefaultBeanIdentifiers.BOOTSTRAP_LOADER ) as BootstrapLoader;
					_preloader.parser = parser;
					
					//_preloader.flashvars = _flashvars;
					
					//trace("DefaultApplication::setFlashVariables()", _preloader );
						
					//update with the framework beans xref
					beans = _preloader.resources.document;
					beans.id = DefaultBeanIdentifiers.APPLICATION;
					beans.xrefs.push( this.framework );

					//trace("DefaultApplication::setFlashVariables()", beans, beans.xrefs.length );
			
					preloader.addEventListener(
						ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
						configurationLoadComplete );
				
					preloader.addEventListener(
						RslEvent.LOAD_COMPLETE, rslLoadComplete );
						
					doWithFrameworkBeans( this.framework );
				}
			}
		}
		
		/**
		*	The type of bean document to instantiate.
		*/	
		protected function getBeanDocumentClass():Class
		{
			return BeanDocument;
		}
		
		/**
		* 	Gets the default bean document to use for the application.
		*/
		protected function getBeanDocument():IBeanDocument
		{
			if( _framework == null )
			{
				_framework = BeanDocumentFactory.create(
					getBeanDocumentClass() );
				_framework.id = DefaultBeanIdentifiers.FRAMEWORK;
			}
			return _framework;
		}
		
		/**
		* 	Exposes the main bean document for the application.
		*/
		public function get framework():IBeanDocument
		{
			if( _framework == null )
			{
				getBeanDocument();
			}
			return _framework;
		}
		
		/**
		* 	Gets the parser implementation used to deserialize the
		* 	configuration document.
		*/
		public function getConfigurationParser( document:IBeanDocument ):IParser
		{
			return new ConfigurationParser( document );
		}		
		
		/**
		* 	@private
		*/
		private function created( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, created );
			
			//start the load process
			preloader.load();
		}
		
		/**
		* 	Invoked when the configuration has been loaded and parsed.
		*	
		*	The default behaviour is to assign a reference to the parsed
		*	configuration object.
		*	
		*	@param event The configuration event.
		*/
		private function configurationLoadComplete(
			event:ConfigurationEvent ):void
		{
			removeEventListener(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				configurationLoadComplete );
			
			//keep a reference to the configuration
			_configuration = IConfiguration( event.configuration );
			
			//update the configuration with the flash variables
			_configuration.flashvars = this.flashvars;
			
			//update the style bindings to match the xml bindings
			_preloader.resources.styleManager.bindings = Deserializer.defaultBindings.clone();
			
			configure( _configuration );
		}
		
		/**
		* 	@private
		*/
		private function rslLoadComplete( event:RslEvent ):void
		{
			removeEventListener( RslEvent.LOAD_COMPLETE, rslLoadComplete );
			ready();
		}
		
		/**
		*	Invoked when the configuration is parsed and
		*	available for use.
		*	
		*	The default behaviour is to do nothing you can
		*	override this method to perform operations with
		*	the configuration as soon as it is available.
		*/
		protected function configure(
			configuration:IConfiguration ):void
		{
			//
			var beans:IBeanDocument = configuration.resources.document;
			
			//allow the main application bean document to access all the beans
			//in the style sheet bean document
			beans.xrefs.push( configuration.stylesheet );
			
			//standard bean configuration
			var beanConfiguration:BeanConfiguration = new BeanConfiguration();
			
			//trace("DefaultApplication::configure()", beans, configuration, preloader.resources );
		
			//TODO: configure with global resources
			beanConfiguration.doWithBeans( beans, configuration, preloader.resources );
		
			//bean configuration specific to a view based bootstrap
			var mainApplicationViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MAIN_APPLICATION_VIEW, preloader.main );
			var bootstrapLoaderBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.BOOTSTRAP_LOADER, preloader );
			var preloaderViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PRELOADER_VIEW, preloader.view );
			
			//main application view
			beans.addBeanDescriptor( mainApplicationViewBean );
			//bootstrap loader
			beans.addBeanDescriptor( bootstrapLoaderBean );	
			//preloader view
			beans.addBeanDescriptor( preloaderViewBean );			
		
			//trace("DefaultApplication::configure()", beans, beans.xrefs.length );
		}
		
		/**
		*	Invoked when all runtime assets have been loaded and
		*	the application is ready to start.
		*	
		*	The default behaviour is to create the main controller and
		*	add it to the display list if it is a display object.
		*/
		protected function ready():void
		{
			if( _configuration == null )
			{
				throw new Error( "Cannot start an application with no configuration." );
			}
			createMainController();
		}
		
		/**
		* 	@private
		*/
		private function doWithBeans( beans:IBeanDocument ):void
		{
			//					
		}
		
		/**
		* 	@private
		* 
		*	Creates the main application controller.
		* 
		* 	If the main controller is a display object it will be added
		* 	to the display list.
		* 
		* 	If the main controller implements the <code>IApplicationMainController</code> interface
		* 	it's <code>ready</code> implementation will be invoked.
		*/
		private function createMainController():void
		{
			var document:IBeanDocument = _configuration.resources.document;
			doWithBeans( document );
			
			var application:Object = document.getBean(
				DefaultBeanIdentifiers.APPLICATION );
				
			if( application == null )
			{
				throw new Error( "Could not locate main application controller with identifier '"
				 	+ DefaultBeanIdentifiers.APPLICATION + "'.");
			}
			
			if( application )
			{
				if( application is IConfigurationAware )
				{
					IConfigurationAware( application ).configuration = _configuration;
				}
				
				//var config:IClassPathConfiguration = preloader.main.classes;
				
				//add to the stage if the application is a display list
				if( application is DisplayObject )
				{
					addChild( DisplayObject( application ) );
				}				
				
				if( application is IApplicationMainController )
				{
					//invoke the ready method
					var cleanup:Boolean = IApplicationMainController( application ).ready(
						this,
						preloader.main,
						preloader,
						preloader.view );
			
					if( cleanup )
					{
						//remove the preloader view from the display list
						preloader.view = null;
					}
				}
			}
		}
	}
}