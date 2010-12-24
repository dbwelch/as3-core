package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.io.xml.Deserializer;
	
	import com.ffsys.ioc.*;	
	
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
		
		private var _document:IBeanDocument;
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
						parser,
						_flashvars );
			
					preloader.addEventListener(
						ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
						configurationLoadComplete );
				
					preloader.addEventListener(
						RslEvent.LOAD_COMPLETE, rslLoadComplete );
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
			if( _document == null )
			{
				_document = BeanDocumentFactory.create(
					getBeanDocumentClass() );
			}
			return _document;
		}
		
		/**
		* 	Exposes the main bean document for the application.
		*/
		public function get document():IBeanDocument
		{
			if( _document == null )
			{
				getBeanDocument();
			}
			return _document;
		}
		
		/**
		* 	@private
		*/
		private function created( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, created );
			
			//TODO: create default beans here
			var beans:IBeanDocument = this.document;
			var configuration:IBeanConfiguration = new ApplicationBeanConfiguration();
			configuration.doWithBeans( beans );
			
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
			_configuration.styleManager.bindings = Deserializer.defaultBindings.clone();
			
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
			//standard bean configuration
			var beanConfiguration:BeanConfiguration = new BeanConfiguration();
			
			//TODO: configure with global resources
			beanConfiguration.doWithBeans( beans, _configuration, _preloader.resources );
			
			//bean configuration specific to a view based bootstrap
			var mainApplicationViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MAIN_APPLICATION_VIEW, preloader.main );
			var bootstrapLoaderBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.BOOTSTRAP_PRELOADER, preloader );
			var preloaderViewBean:IBeanDescriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PRELOADER_VIEW, preloader.view );
				
			//main application view
			beans.addBeanDescriptor( mainApplicationViewBean );
			//bootstrap loader
			beans.addBeanDescriptor( bootstrapLoaderBean );	
			//preloader view
			beans.addBeanDescriptor( preloaderViewBean );					
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
				DefaultBeanIdentifiers.APPLICATION_BEAN );
			
			if( application )
			{
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