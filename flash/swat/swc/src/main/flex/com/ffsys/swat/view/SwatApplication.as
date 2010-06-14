package com.ffsys.swat.view  {
	
	import flash.events.Event;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.core.RuntimeAssetPreloader;
	
	import com.ffsys.swat.events.ConfigurationEvent;
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.ConfigurationLoader;
	
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
		private var _configurationLoader:ConfigurationLoader;
		
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
		*	@inheritDoc	
		*/
		public function set preloader( preloader:IRuntimeAssetPreloader ):void
		{
			_preloader = _preloader;
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
		public function set flashvars( flashvars:IFlashVariables ):void
		{
			if( !_flashvars )
			{
				_flashvars = flashvars;
				_preloader = new RuntimeAssetPreloader( _flashvars );
			
				preloader.addEventListener(
					ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE, configurationAvailable );
				
				preloader.addEventListener(
					RslEvent.LOAD_COMPLETE, assetsAvailable );
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
		* 	@private
		*/
		protected function configurationAvailable( event:ConfigurationEvent ):void
		{
			removeEventListener( ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE, configurationAvailable );
			
			//keep a reference to the configuration
			this.configuration = event.configuration;
		}
		
		/**
		* 	@private
		*/
		protected function assetsAvailable( event:RslEvent ):void
		{
			removeEventListener( RslEvent.LOAD_COMPLETE, assetsAvailable );
			
			//create the views
			createChildren();
		}
	}
}