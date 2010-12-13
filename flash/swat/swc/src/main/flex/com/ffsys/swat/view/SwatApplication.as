package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.io.xml.Deserializer;
	
	//import com.ffsys.ui.text.core.ITextFieldFactory;
	
	import com.ffsys.di.*;	
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.core.RuntimeAssetPreloader;
	
	import com.ffsys.swat.events.ConfigurationEvent;
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.DefaultBeanIdentifiers;	
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationParser;
	import com.ffsys.swat.core.SwatFlashVariables;
	
	/**
	*	Abstract super class for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatApplication extends AbstractSwatView
		implements IApplication {
		
		private var _preloader:IRuntimeAssetPreloader;
		private var _flashvars:IFlashVariables;
		
		/**
		*	Creates a <code>SwatApplication</code> instance.
		*/
		public function SwatApplication()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, created );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get preloader():IRuntimeAssetPreloader
		{
			return _preloader;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function createChildren():void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		override public function get flashvars():IFlashVariables
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
						SwatFlashVariables( _flashvars ).classPathConfiguration;
					
					var parser:IConfigurationParser = 
						classPathConfiguration.getConfigurationParserInstance();
					/*
					parser.interpreter.bindings.addBinding(
						new Binding() );
					*/
					
					_preloader = new RuntimeAssetPreloader(
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
			utils.configuration = event.configuration;
			
			//update the configuration with the flash variables
			utils.configuration.flashvars = this.flashvars;
			
			//update the style bindings to match the xml bindings
			utils.styleManager.bindings = Deserializer.defaultBindings.clone();
			
			trace("SwatApplication::configurationLoadComplete()", utils.styleManager.bindings.getLength() );
			
			configure( utils.configuration );
		}
		
		/**
		* 	@private
		*/
		private function rslLoadComplete( event:RslEvent ):void
		{
			removeEventListener( RslEvent.LOAD_COMPLETE, rslLoadComplete );
			//propagateComponentTextFactory();
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
		*	The default behaviour is to create the main view and
		*	add it to the display list.
		*/
		protected function ready():void
		{
			createMainView();
		}
		
		private function doWithBeans( beans:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.CONFIGURATION, utils.configuration );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.FLASH_VARIABLES, utils.configuration.flashvars );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PATHS, utils.configuration.paths );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.LOCALES, utils.configuration.locales );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.MAIN_APPLICATION_VIEW, preloader.main );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.BOOTSTRAP_PRELOADER, preloader );
			beans.addBeanDescriptor( descriptor );
			descriptor = new InjectedBeanDescriptor(
				DefaultBeanIdentifiers.PRELOADER_VIEW, preloader.view );
			beans.addBeanDescriptor( descriptor );
		}
		
		/**
		*	Creates the main view and adds it to the display list.	
		*/
		protected function createMainView():void
		{
			doWithBeans( utils.configuration.locales.document );
			
			var application:Object = getBean( DefaultBeanIdentifiers.APPLICATION_BEAN );
			
			if( application )
			{
				//trace("SwatApplication::createMainView()", "GOT APPLICATION BEAN" );
				
				//ensure the ready method has access to the configuration
				if( application is IApplicationView )
				{
					IApplicationView( application ).utils.configuration = utils.configuration;
				}
			
				if( application is IApplicationMainView )
				{
					//invoke the ready method
					var cleanup:Boolean = IApplicationMainView( application ).ready(
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
			//var view:DisplayObject = config.getMainViewInstance();

			if( application && ( application is DisplayObject ) )
			{
				addChild( DisplayObject( application ) );
			}
		}
		
		/**
		*	@private
		*	
		*	Checks whether the component module is compiled in
		*	and propagates the swat textfield factory to the component
		*	textfield factory.
		*/
		
		/*
		private function propagateComponentTextFactory():void
		{
			var classPath:String = "com.ffsys.ui.core.UIComponent";
			
			var clz:Class = null;
			var instance:Object = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
				instance = new clz();
				
				//add and remove the component so that
				//components are pre-initialized before the
				//main application view is instantiated
				addChild( DisplayObject( instance ) );
				removeChild( DisplayObject( instance ) );
			}catch( e:Error )
			{
				//ignore if the components are not compiled or instantiation error
				//throw e;
			}
			
			if( instance != null )
			{
				var factory:ITextFieldFactory;				
			
				if( !instance.hasOwnProperty( "textFieldFactory" ) )
				{
					throw new Error(
						"Cannot propagate textfield factory defaults, missing factory on the ui component suite." );
				}else{
					factory = ITextFieldFactory(
						instance.textFieldFactory );
				}
			
				if( factory )
				{
					factory.defaultTextFieldProperties =
						utils.textFieldFactory.defaultTextFieldProperties;			

					factory.defaultTextFormatProperties =
						utils.textFieldFactory.defaultTextFormatProperties;
				}
			
			}
		}
		*/
	}
}