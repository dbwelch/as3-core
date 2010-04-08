package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.display.IDisplayVideo;
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IVideoAccess;
	import com.ffsys.io.loaders.resources.VideoResource;
	
	/**
	*	Event dispatched when video data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class VideoLoadEvent extends LoadEvent
		implements IVideoAccess {
		
		public function VideoLoadEvent(
			event:Event,
			loader:ILoader,
			resource:VideoResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get video():IDisplayVideo
		{
			return VideoResource( resource ).video;
		}
		
		override public function clone():Event
		{
			return new VideoLoadEvent( triggerEvent, loader, VideoResource( resource ) );
		}
		
		override public function toString():String
		{
			return "[object VideoLoadEvent]" + super.toString();
		}
		
	}
	
}
