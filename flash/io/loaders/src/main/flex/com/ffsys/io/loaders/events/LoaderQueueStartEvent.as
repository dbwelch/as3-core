package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Event dispatched when a queue starts loading an item.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class LoaderQueueStartEvent extends LoadEvent {
		
		static public const LOAD_ITEM_START:String = "loadItemStart";
		
		public function LoaderQueueStartEvent( event:Event = null, loader:ILoader = null )
		{
			super( LOAD_ITEM_START, event, loader );
		}
		
		override public function clone():Event
		{
			return new LoaderQueueStartEvent( triggerEvent, loader );
		}
		
	}
	
}
