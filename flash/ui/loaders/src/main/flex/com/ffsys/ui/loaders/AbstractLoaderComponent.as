package com.ffsys.ui.loaders
{
	import flash.display.DisplayObject;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;

	/**
	*	Abstract super class for instances that load visual assets
	* 	and add them to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractLoaderComponent extends InteractiveComponent
		implements ILoaderComponent
	{
		private var _container:IComponent;
		private var _loader:ILoader;
		private var _deferred:Boolean = false;
	
		/**
		* 	Creates an <code>AbstractLoaderComponent</code> instance.
		* 
		* 	@param loader The loader responsible for loading the runtime
		* 	asset.
		* 	@param deferred Whether the load process is deferred until the
		* 	user calls the load method. The default behaviour is for the load
		* 	process to start when the loader component is added to the display list.
		*/
		public function AbstractLoaderComponent(
			loader:ILoader,
			deferred:Boolean = false )
		{
			super();
			_container = new UIComponent();
			addChild( DisplayObject( _container ) );
			_loader = loader;
			_deferred = deferred;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get container():IComponent
		{
			return _container;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get deferred():Boolean
		{
			return _deferred;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set deferred( deferred:Boolean ):void
		{
			_deferred = deferred;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get uri():String
		{
			return loader.uri;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set uri( uri:String ):void
		{
			loader.uri = uri;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loader():ILoader
		{
			return _loader;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load():void
		{
			removeLoaderListeners();
			addLoaderListeners();
				
			//start loading when we are created
			loader.load( loader.request );
		}
		
		/**
		*	@inheritDoc 
		*/
		override protected function createChildren():void
		{
			if( !deferred && !loader.loading )
			{
				load();
			}
		}
		
		/**
		* 	@private
		*/
		private function addLoaderListeners():void
		{
			_loader.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_loader.addEventListener(
				LoadStartEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_loader.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_loader.addEventListener(
				LoadEvent.DATA,
				loadComplete, false, 0, false );
		}
		
		/**
		* 	@private
		*/
		private function removeLoaderListeners():void
		{
			_loader.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_loader.removeEventListener(
				LoadStartEvent.LOAD_START,
				loadStart );
				
			_loader.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress );
			
			_loader.removeEventListener(
				LoadEvent.DATA,
				loadComplete );
		}
		
		/**
		*	@private
		*/
		protected function loadStart( event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::loadStart()");
		}
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::resourceNotFound()");
		}
		
		/**
		*	@private
		*/
		protected function loadProgress( 
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::loadProgress()");
		}
		
		/**
		*	@private
		*/
		protected function loadComplete( 
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event	
			//trace("AbstractLoaderComponent::loadComplete()");
			
			//cleanup the listeners
			removeLoaderListeners();
			
			if( this.border )
			{
				this.border.draw( this.width, this.height );
			}
		
			if( this.background )
			{
				this.background.draw( this.width, this.height );
			}
		}
		
	}
}