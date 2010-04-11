package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Event dispatched when the an external resource starts loading.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class LoadStartEvent extends LoadEvent {
		
		static public const LOAD_START:String = "loadStart";
		
		public function LoadStartEvent( event:Event, loader:ILoader )
		{
			super( LOAD_START, event, loader );
		}
		
		override public function clone():Event
		{
			return new LoadStartEvent( triggerEvent, loader );
		}
		
	}
	
}
