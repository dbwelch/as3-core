package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	/**
	*	Event dispatched when the an external resource has completed loading.
	*
	*	This implies the types data is available and the LoadEvent.DATA
	*	event has been dispatched.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public class LoadCompleteEvent extends LoadEvent {
		
		static public const LOAD_COMPLETE:String = "loadComplete";
		
		public function LoadCompleteEvent(
			event:Event = null,
			loader:ILoader = null,
			resource:IResourceList = null )
		{
			
			if( !event )
			{
				event = new Event( Event.COMPLETE );
			}
			
			super( LOAD_COMPLETE, event, loader, resource as IResourceList );
		}
		
		override public function clone():Event
		{
			return new LoadCompleteEvent( triggerEvent, loader, resource as IResourceList );
		}		
		
	}
	
}