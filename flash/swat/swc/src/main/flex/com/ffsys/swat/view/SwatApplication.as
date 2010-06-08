package com.ffsys.swat.view  {
	
	import flash.events.Event;
	
	import com.ffsys.swat.core.RuntimeAssetPreloader;
	import com.ffsys.swat.core.SwatFlashVariables;
	
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
	public class SwatApplication extends AbstractSwatView
		implements IApplication {
		
		private var _preloader:RuntimeAssetPreloader;
		private var _flashvars:SwatFlashVariables;
		
		/**
		*	Creates a <code>SwatApplication</code> instance.
		*/
		public function SwatApplication( flashvars:SwatFlashVariables )
		{
			super();
			
			_preloader = new RuntimeAssetPreloader( flashvars );

			_preloader.addEventListener(
				ConfigurationEvent.CONFIGURATION_AVAILABLE, configurationAvailable );
				
			_preloader.addEventListener(
				RslEvent.LIBRARY_LOADED, assetsAvailable );
			
			addEventListener( Event.ADDED_TO_STAGE, created );
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
		public function get flashvars():SwatFlashVariables
		{
			return _flashvars;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set flashvars( flashvars:SwatFlashVariables ):void
		{
			_flashvars = flashvars;
		}
		
		
		/**
		* 	@private
		*/
		private function created( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, created );
			//start the load process
			_preloader.load();
		}
		
		/**
		* 	@private
		*/
		protected function configurationAvailable( event:ConfigurationEvent ):void
		{
			removeEventListener( ConfigurationEvent.CONFIGURATION_AVAILABLE, configurationAvailable );
			
			//keep a reference to the configuration
			this.configuration = event.configuration;
		}
		
		/**
		* 	@private
		*/
		protected function assetsAvailable( event:RslEvent ):void
		{
			removeEventListener( RslEvent.LIBRARY_LOADED, assetsAvailable );
			
			//create the views
			createChildren();
		}
	}
}