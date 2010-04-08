package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.http.HttpResponse;
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IHttpAccess;
	import com.ffsys.io.loaders.resources.HttpResource;
	
	/**
	*	Event dispatched when an HTTP header has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public class HeaderLoadEvent extends LoadEvent
		implements IHttpAccess {
		
		public function HeaderLoadEvent(
			event:Event,
			loader:ILoader,
			resource:HttpResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get response():HttpResponse
		{
			return HttpResource( resource ).response;
		}
		
		override public function clone():Event
		{
			return new HeaderLoadEvent( triggerEvent, loader, HttpResource( resource ) );
		}		
		
	}
	
}
