package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Super class for all load events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public class LoadEvent extends AbstractLoadEvent {
		
		/**
		*	Event dispatched when a runtime asset starts loading.	
		*/
		static public const LOAD_START:String = "loadStart";
		
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
		
		public function LoadEvent(
			type:String,
			triggerEvent:Event,
			loader:ILoader,
			resource:IResourceElement = null )
		{
			super( type, triggerEvent, loader );
			this.resource = resource;
		}
		
		override public function clone():Event
		{
			return new LoadEvent( type, triggerEvent, loader, resource );
		}
	}
}