package com.ffsys.swat.core {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.types.*;

	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.rsls.IResourceQueueBuilder;
	
	/**
	*	Preloads runtime resources by type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ResourceLoader extends EventDispatcher
		implements IResourceLoader {

		private var _builder:IResourceQueueBuilder;
		private var _phaseIndex:int = -1;
		private var _phases:Array = ResourceLoadPhase.defaults;
		
		/**
		* 	@private
		*/
		protected var _assets:ILoaderQueue;
		
		/**
		* 	@private
		*/
		protected var _phase:String = null;
		
		/**
		*	Creates a <code>ResourceLoader</code> instance.
		*/
		public function ResourceLoader()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get builder():IResourceQueueBuilder
		{
			return _builder;
		}
		
		public function set builder( value:IResourceQueueBuilder ):void
		{
			_builder = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phases():Array
		{
			return _phases;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phase():String
		{
			return _phase;
		}
		
		/**
		*	@inheritDoc
		*/
		public function load():ILoaderQueue
		{
			if( this.builder == null )
			{
				throw new Error( "Cannot load resources with a null resource queue builder." );
			}
			if( this.phases == null )
			{
				throw new Error( "Cannot load resources with no load phases." );
			}
			if( _assets )
			{
				_assets.close();
				removeQueueListeners();
			}
			_assets = getLoaderQueue( this.builder );
			if( !_assets.isEmpty() )
			{
				_phase = _assets.first().id;
				addQueueListeners();
				_assets.load();
			}
			return _assets;
		}
		
		/**
		* 	Closes any open connections and cleans composite references.
		*/
		public function destroy():void
		{
			if( _assets )
			{
				_assets.close();
			}
			_assets = null;
			_phase = null;
			_phases = null;
			_builder = null;
		}
		
		/**
		* 	@private
		*/
		protected function getLoaderQueue( builder:IResourceQueueBuilder ):ILoaderQueue
		{
			var output:ILoaderQueue = new LoaderQueue();
			var queue:ILoaderQueue = null;
			var phase:String = null;
			for( var i:int = 0;i < this.phases.length;i++ )
			{
				phase = this.phases[ i ];
				queue = builder.getQueueByPhase( phase );
				if( queue && !queue.isEmpty() )
				{
					queue.id = phase;
					queue.addEventListener( LoadEvent.LOAD_COMPLETE, phaseLoadComplete );
					output.addLoader( queue );
				}
			}
			return output;
		}
		
		/**
		*	@private	
		*/
		protected function addQueueListeners():void
		{
			if( _assets )
			{
				_assets.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound, false, 0, false );
				
				_assets.addEventListener(
					LoadEvent.LOAD_START,
					loadStart, false, 0, false );
			
				_assets.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress, false, 0, false );
			
				_assets.addEventListener(
					LoadEvent.DATA,
					itemLoaded, false, 0, false );
				
				_assets.addEventListener(
					LoadEvent.LOAD_COMPLETE,
					loadComplete, false, 0, false );
			}
		}
		
		/**
		*	@private
		*/
		protected function removeQueueListeners():void
		{
			if( _assets )
			{
				_assets.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				_assets.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				_assets.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
				
				_assets.removeEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				_assets.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					loadComplete );
			}
		}
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:LoadEvent ):void
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.RESOURCE_NOT_FOUND,
				this,
				event );
			dispatchEvent( evt );
		}
		
		/**
		*	@private
		*/
		protected function loadStart( event:LoadEvent ):void
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_START,
				this,
				event );
			dispatchEvent( evt );	
		}
		
		/**
		*	@private
		*/
		protected function loadProgress( 
			event:LoadEvent ):void
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_PROGRESS,
				this,
				event );
			dispatchEvent( evt );
		}	
		
		/**
		*	@private
		*/
		protected function itemLoaded( event:LoadEvent ):void
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOADED,
				this,
				event );
			dispatchEvent( evt );
		}		
		
		/**
		*	@private
		*/
		protected function loadComplete( event:LoadEvent ):void
		{
			trace("ResourceLoader::loadComplete()", "ALL RESOURCES HAVE BEEN LOADED" );
			
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this );	
			dispatchEvent( evt );			
		}
		
		/**
		*	@private
		*/
		protected function phaseLoadComplete( event:LoadEvent ):void
		{
			event.target.removeEventListener(
				event.type, arguments.callee );
			_phase = event.loader.id;
			trace("ResourceLoader::loadComplete()", "ALL RESOURCES FOR THE PHASE HAVE BEEN LOADED", _phase );	
			_phaseIndex++;
		}
	}
}