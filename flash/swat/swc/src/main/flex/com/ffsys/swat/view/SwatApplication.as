package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.ui.text.core.ITextFieldFactory;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.core.RuntimeAssetPreloader;
	
	import com.ffsys.swat.events.ConfigurationEvent;
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	
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
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set flashvars(
			flashvars:IFlashVariables ):void
		{
			if( !_flashvars )
			{
				_flashvars = flashvars;
				
				if( !_preloader )
				{
					_preloader = new RuntimeAssetPreloader( _flashvars );
			
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
			
			if( utils.configuration.defaults )
			{
				utils.textFieldFactory.defaultTextFieldProperties =
					utils.configuration.defaults.textfield;
					
				utils.textFieldFactory.defaultTextFormatProperties =
					utils.configuration.defaults.textformat;
			}
			
			//update the configuration with the flash variables
			utils.configuration.flashvars = this.flashvars;
			
			configure( utils.configuration );
		}
		
		/**
		* 	@private
		*/
		private function rslLoadComplete( event:RslEvent ):void
		{
			removeEventListener( RslEvent.LOAD_COMPLETE, rslLoadComplete );
			propagateComponentTextFactory();
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
		
		/**
		*	Creates the main view and adds it to the display list.	
		*/
		protected function createMainView():void
		{
			var config:IClassPathConfiguration = preloader.main.classes;
			var view:DisplayObject = config.getMainViewInstance();
			
			if( !( view is IApplicationMainView ) )
			{
				throw new Error(
					"The main application view does not"
					+ " adhere to the application main view contract." );
			}
			
			//ensure the ready method has access to the configuration
			IApplicationMainView( view ).utils.configuration = utils.configuration;
			
			//invoke the ready method
			var cleanup:Boolean = IApplicationMainView( view ).ready(
				preloader.main,
				preloader,
				preloader.view );
				
			if( cleanup )  
			{
				//remove the preloader view from the display list
				preloader.view = null;
			}
			
			addChild( view );
		}
		
		/**
		*	@private
		*	
		*	Checks whether the component module is compiled in
		*	and propagates the swat textfield factory to the component
		*	textfield factory.
		*/
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
			}catch( e:Error )
			{
				//ignore if the components are not compiled or instantiation error
				
				throw e;
			}
			
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
}