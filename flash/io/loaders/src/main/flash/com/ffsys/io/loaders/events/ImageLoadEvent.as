package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.display.IDisplayImage;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IImageAccess;
	import com.ffsys.io.loaders.resources.ImageResource;
	
	/**
	*	Event dispatched when image data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class ImageLoadEvent extends LoadEvent
		implements IImageAccess {
		
		public function ImageLoadEvent(
			event:Event,
			loader:ILoader,
			resource:ImageResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get image():IDisplayImage
		{
			return ImageResource( resource ).image;
		}
		
		override public function clone():Event
		{
			return new ImageLoadEvent( triggerEvent, loader, ImageResource( resource ) );
		}
		
		override public function toString():String
		{
			return "[object ImageLoadEvent]" + super.toString();
		}
		
	}
	
}
