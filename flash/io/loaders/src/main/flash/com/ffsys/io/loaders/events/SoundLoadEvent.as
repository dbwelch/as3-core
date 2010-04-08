package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.media.Sound;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.ISoundAccess;
	import com.ffsys.io.loaders.resources.SoundResource;
	
	/**
	*	Event dispatched when Sound data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class SoundLoadEvent extends LoadEvent
		implements ISoundAccess {
		
		public function SoundLoadEvent(
			event:Event,
			loader:ILoader,
			resource:SoundResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get sound():Sound
		{
			return SoundResource( resource ).sound;
		}
		
		override public function clone():Event
		{
			return new SoundLoadEvent( triggerEvent, loader, SoundResource( resource ) );
		}		
		
	}
	
}
