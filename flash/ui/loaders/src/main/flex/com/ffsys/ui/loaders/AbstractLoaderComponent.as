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
		private var _urls:Array;
		private var _deferred:Boolean = true;
	
		/**
		* 	Creates an <code>AbstractLoaderComponent</code> instance.
		* 
		* 	@param urls An array of urls to load.
		*/
		public function AbstractLoaderComponent( urls:Array = null )
		{
			super();
			this.urls = urls;
		}
		
		public function get urls():Array
		{
			return _urls;
		}
		
		public function set urls( urls:Array ):void
		{
			_urls = urls;
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
			if( loader )
			{
				return loader.uri;
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loader():ILoader
		{
			return _loader;
		}
		
		public function hasUrls():Boolean
		{
			return ( this.urls != null ) && ( this.urls.length > 0 );
		}
		
		/**
		* 	Gets the loader used to load the runtime asset.
		* 
		* 	@param url The url to load.
		* 
		*	@return The loader that is responsible for loading
		* 	the asset.
		*/
		protected function getLoader( url:String ):ILoader
		{
			throw new Error( "You must implement the get loader method in your concrete implementation." );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load():void
		{
			if( !hasUrls() )
			{
				throw new Error( "Cannot load with no urls." );
			}
			
			//TODO: update this to be based on current index
			var url:String = this.urls[ 0 ];
			
			if( !loader )
			{
				_loader = getLoader( url );
			}
			
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
			_container = new UIComponent();
			addChild( DisplayObject( _container ) );			
			
			if( !deferred )
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