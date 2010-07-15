package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.ITextAccess;
	import com.ffsys.io.loaders.resources.TextResource;
	
	/**
	*	Event dispatched when text data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class TextLoadEvent extends LoadEvent
		implements ITextAccess {
		
		public function TextLoadEvent(
			event:Event,
			loader:ILoader,
			resource:TextResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get text():String
		{
			return TextResource( resource ).text;
		}
		
		override public function clone():Event
		{
			return new TextLoadEvent( triggerEvent, loader, TextResource( resource ) );
		}
	}
}
