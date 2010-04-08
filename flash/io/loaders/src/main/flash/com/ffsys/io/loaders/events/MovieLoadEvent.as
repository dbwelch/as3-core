package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.display.IDisplayMovie;
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IMovieAccess;
	import com.ffsys.io.loaders.resources.MovieResource;
	
	/**
	*	Event dispatched when movie (swf) data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class MovieLoadEvent extends LoadEvent
		implements IMovieAccess {
		
		public function MovieLoadEvent(
			event:Event,
			loader:ILoader,
			resource:MovieResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get movie():IDisplayMovie
		{
			return MovieResource( resource ).movie;
		}
		
		override public function clone():Event
		{
			return new MovieLoadEvent( triggerEvent, loader, MovieResource( resource ) );
		}
		
		override public function toString():String
		{
			return "[object MovieLoadEvent]" + super.toString();
		}
		
	}
	
}
