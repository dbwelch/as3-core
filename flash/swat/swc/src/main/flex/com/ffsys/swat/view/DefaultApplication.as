package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.io.xml.Deserializer;
	
	import com.ffsys.ioc.*;	
	
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.BootstrapLoader;
	

	import com.ffsys.swat.configuration.DefaultBeanIdentifiers;
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.IConfigurationParser;
	import com.ffsys.swat.core.DefaultFlashVariables;
	import com.ffsys.swat.core.IApplicationMainController;
	import com.ffsys.swat.core.IFlashVariablesAware;
	import com.ffsys.swat.core.IMessagesAware;
	
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
					var classPathConfiguration:IClassPathConfiguration = 
						DefaultFlashVariables( _flashvars ).classPathConfiguration;
					
					var parser:IConfigurationParser = 
						classPathConfiguration.getConfigurationParserInstance() as IConfigurationParser;
						
					if( parser == null )
					{
						throw new Error( "Could not retrieve a valid configuration parser." );
					}
					
					_preloader = new BootstrapLoader(
						_flashvars,
						parser );
			
					preloader.addEventListener(
						ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
						configurationLoadComplete );
				
					preloader.addEventListener(
						RslEvent.LOAD_COMPLETE, rslLoadComplete );
				}
			}
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
			_configuration.locales.styleManager.bindings = Deserializer.defaultBindings.clone();
			
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
			createMainController();
		}
		
		/**
		* 	Configures the default injector beans for the application.
		* 
		* 	These are objects that have already been instantiated and
		* 	should be made available to bean documents.
		*/
		protected function doWithBeans( beans:IBeanDocument ):void
		{
			if( beans == null )
			{
				throw new Error( "Cannot modify a null bean document." );
			}

			var configurationBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.CONFIGURATION, _configuration )
			var flashvarsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.FLASH_VARIABLES, _configuration.flashvars );
			var localesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.LOCALES, _configuration.locales );
			var messagesBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MESSAGES, _configuration.locales.messages );
			var pathsBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PATHS, _configuration.paths );
			var mainApplicationViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MAIN_APPLICATION_VIEW, preloader.main );
			var bootstrapLoaderBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.BOOTSTRAP_PRELOADER, preloader );
			var preloaderViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PRELOADER_VIEW, preloader.view );
			
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
			//main application view
			beans.addBeanDescriptor( mainApplicationViewBean );
			//bootstrap loader
			beans.addBeanDescriptor( bootstrapLoaderBean );	
			//preloader view
			beans.addBeanDescriptor( preloaderViewBean );	
		
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
				DefaultBeanIdentifiers.MESSAGES,
				DefaultBeanIdentifiers.MESSAGES,
				IMessagesAware,
				messagesBean ) );
		}
		
		/**
		*	Creates the main controller.
		* 
		* 	If the main controller is a display object it will be added
		* 	to the display list.
		* 
		* 	If the main controller implements the IApplicationMainController interface
		* 	it's ready implementation will be invoked.
		*/
		protected function createMainController():void
		{
			var document:IBeanDocument = _configuration.locales.document;
			doWithBeans( document );
			
			var application:Object = document.getBean(
				DefaultBeanIdentifiers.APPLICATION_BEAN );
			
			if( application )
			{
				trace("DefaultApplication::createMainController()", application, application.configuration );
				
				if( application is IConfigurationAware )
				{
					IConfigurationAware( application ).configuration = _configuration;
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
			
			//var config:IClassPathConfiguration = preloader.main.classes;

			if( application && ( application is DisplayObject ) )
			{
				addChild( DisplayObject( application ) );
			}
		}
	}
}