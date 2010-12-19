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
		private var _phases:Array = ResourceLoadPhase.defaults;
		
		/**
		* 	@private
		*/
		protected var _assets:ILoaderQueue;
		
		/**
		* 	@private
		*/
		protected var _phase:String = ResourceLoadPhase.CODE_PHASE;
		
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
				removeQueueListeners( _assets, loadComplete );
			}
			_assets = getLoaderQueue( this.builder );
			if( !_assets.isEmpty() )
			{
				_phase = String( _assets.first().customData );
				addQueueListeners( _assets, loadComplete );
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
					queue.customData = phase;
					output.addLoader( queue );
				}
			}
			return output;
		}
		
		/**
		*	@private	
		*/
		protected function addQueueListeners( queue:ILoaderQueue, complete:Function ):void
		{
			if( queue != null )
			{
				queue.addEventListener(
					LoadEvent.QUEUE_START,
					queueStart );
				
				queue.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
				
				queue.addEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				queue.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
			
				queue.addEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				queue.addEventListener(
					LoadEvent.LOAD_COMPLETE,
					complete );
			}
		}
		
		/**
		*	@private
		*/
		protected function removeQueueListeners( queue:ILoaderQueue, complete:Function ):void
		{
			if( queue != null )
			{
				queue.removeEventListener(
					LoadEvent.QUEUE_START,
					queueStart );
				
				queue.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				queue.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				queue.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
				
				queue.removeEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				queue.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					complete );
			}
		}
		
		/**
		*	@private
		*/
		protected function queueStart(
			event:LoadEvent ):RslEvent
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.PHASE_START,
				this,
				event );
				
			_phase = String( event.loader.customData );
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:LoadEvent ):RslEvent
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.RESOURCE_NOT_FOUND,
				this,
				event );
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function loadStart( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_START,
				this,
				event );
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;					
			dispatchEvent( evt );
			return evt;				
		}
		
		/**
		*	@private
		*/
		protected function loadProgress( 
			event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_PROGRESS,
				this,
				event );
			//evt.bytesLoaded = event.bytesLoaded;
			//evt.bytesTotal = event.bytesTotal;
			
			
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;			
			
			dispatchEvent( evt );
			return evt;			
		}	
		
		/**
		*	@private
		*/
		protected function itemLoaded( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOADED,
				this,
				event );
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;				
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function loadComplete( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this );	
			removeQueueListeners( _assets, loadComplete );
			_phase = ResourceLoadPhase.COMPLETE_PHASE;
			dispatchEvent( evt );
			return evt;			
		}
	}
}