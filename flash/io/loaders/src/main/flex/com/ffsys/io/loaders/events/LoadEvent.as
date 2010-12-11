package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.events.ProgressEvent;	
	import flash.net.URLRequest;
	
	import com.ffsys.events.AbstractEvent;

	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderElement;
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Abstract base class for all load related events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class LoadEvent extends AbstractEvent
		implements ILoadEvent {
			
		/**
		*	Event dispatched when a runtime asset starts loading.	
		*/
		static public const LOAD_START:String = "loadStart";
		
		/**
		*	Event dispatched while a runtime asset is loading.
		*/
		static public const LOAD_PROGRESS:String = "loadProgress";
		
		/**
		*	Event dispatched when the data for a runtime asset is available.
		*/
		static public const DATA:String = "dataLoaded";
		
		/**
		*	Event dispatched when a load process is complete.
		*/
		static public const LOAD_COMPLETE:String = "loadComplete";
		
		/**
		*	Event dispatched by a loader queue prior to loading
		*	an item in the queue.	
		*/
		static public const LOAD_ITEM_START:String = "loadItemStart";
		
		/**
		*	Event dispatched when a runtime asset could not be found.	
		*/
		static public const RESOURCE_NOT_FOUND:String = "resourceNotFound";			
		
		/**
		*	@private
		*/
		private var _loader:ILoaderElement;
		
		/**
		*	@private	
		*/
		private var _resource:IResourceElement;
		
		public function LoadEvent(
			type:String,
			triggerEvent:Event,
			loader:ILoaderElement,
			resource:IResourceElement = null )
		{
			super( type, triggerEvent );
			this.loader = loader;
			this.resource = resource;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get resource():IResourceElement
		{
			return _resource;
		}
				
		public function set resource( value:IResourceElement ):void
		{
			_resource = value;
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function get loader():ILoaderElement
		{
			return _loader;
		}		
		
		public function set loader( value:ILoaderElement ):void
		{
			_loader = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bytesLoaded():uint
		{
			if( triggerEvent && ( triggerEvent is ProgressEvent ) )
			{
				return ProgressEvent( triggerEvent ).bytesLoaded;
			}
			
			if( loader && ( loader is ILoader ) )
			{
				return ILoader( loader ).getBytesLoaded();
			}
			
			return 0;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bytesTotal():uint
		{
			if( triggerEvent && ( triggerEvent is ProgressEvent ) )
			{
				return ProgressEvent( triggerEvent ).bytesTotal;
			}
			
			if( loader && ( loader is ILoader ) )
			{
				return ILoader( loader ).getBytesTotal();
			}
			
			return 0;
		}
		
		/**
		* 	A normalized value between zero and one representing
		* 	the amount of bytes loaded.
		*/
		public function get normalized():Number
		{
			return ( bytesLoaded / bytesTotal ) * 1;
		}
		
		/**
		* 	The percentage progress for a load operation.
		*/
		public function get percentLoaded():int
		{
			return Math.floor( ( bytesLoaded / bytesTotal ) * 100 );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get request():URLRequest
		{
			if( loader && ( loader is ILoader ) )
			{
				return ILoader( loader ).request;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get uri():String
		{
			if( loader && ( loader is ILoader ) )
			{
				return ILoader( loader ).uri;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			if( loader )
			{
				return loader.id;
			}
			
			return null;
		}
		
		/**
		*	Creates a clone of this event.
		*	
		*	@return The cloned event.	
		*/
		override public function clone():Event
		{
			return new LoadEvent(
				type, triggerEvent, loader, resource );
		}
	}
}