package com.ffsys.swat.events {
	
	import flash.events.Event;
	
	import com.ffsys.events.AbstractEvent;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	
	/**
	*	Represents events dispatched while runtime assets
	*	are loading.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class RslEvent extends AbstractEvent {
		
		/**
		*	Event dispatched when a runtime resource could not be found.
		*/
		public static const RESOURCE_NOT_FOUND:String = "rslResourceNotFound";
		
		/**
		*	Event dispatched while a runtime resource is loading.
		*/
		public static const LOAD_PROGRESS:String = "rslLoadProgress";
		
		/**
		*	Event dispatched when a runtime resource starts loading.
		*/
		public static const LOAD_START:String = "rslLoadStart";
		
		/**
		*	Event dispatched when a runtime resource is loaded.
		*/
		public static const LOADED:String = "rslLoaded";
		
		/**
		*	Event dispatched when all runtime resources are loaded.
		*/
		public static const LOAD_COMPLETE:String = "rslLoadComplete";
		
		/**
		*	The total number of bytes.
		*/
		public var bytesTotal:int = 0;
		
		/**
		*	The current number of bytes loaded.	
		*/
		public var bytesLoaded:int = 0;
		
		private var _preloader:IRuntimeAssetPreloader;
		private var _uri:String;
		
		/**
		*	Creates a <code>RslEvent</code> instance.
		*	
		*	@param type The event type.
		*	@param preloader The runtime asset preloader.
		*	@param event A source event that triggered this event.
		*/
		public function RslEvent(
			type:String,
			preloader:IRuntimeAssetPreloader,
			event:Event = null )
		{
			super( type, event );
			_preloader = preloader;
		}
		
		/**
		*	Gets the runtime asset preloader.
		*	
		*	@return The runtime asset preloader.
		*/
		public function get preloader():IRuntimeAssetPreloader
		{
			return _preloader;
		}
		
		/**
		*	Gets a normalized value of the bytes loaded
		*	between zero and one.
		*	
		*	@return The normalized bytes loaded.	
		*/
		public function get normalized():Number
		{
			if( bytesTotal == 0 )
			{
				return 0;
			}
			
			return ( bytesLoaded / bytesTotal );
		}
		
		public function set uri( uri:String ):void
		{
			_uri = uri;
		}
		
		public function get uri():String
		{
			if( _uri )
			{
				return _uri;
			}
			
			if( triggerEvent && ( triggerEvent is ILoadEvent ) )
			{
				return ILoadEvent( triggerEvent ).uri;
			}
			
			return null;
		}
		
		public function get name():String
		{
			var output:String = null;
			if( uri != null )
			{
				output = uri;
				var slash:int = uri.lastIndexOf( "/" );
				if( slash > -1 )
				{
					return uri.substr( slash + 1 );
				}
			}
			
			return output;
		}

		/**
		*	Creates a clone of this event.
		*	
		*	@return The cloned event.	
		*/
		override public function clone():Event
		{
			var event:RslEvent = new RslEvent(
				type, preloader, triggerEvent );
			event.bytesLoaded = bytesLoaded;
			event.bytesTotal = bytesTotal;
			return event;
		}
	}
}