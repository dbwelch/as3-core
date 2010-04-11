package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Represents a resource not found event that can be
	*	dispatched when an error occurs loading an external
	*	resource.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public class ResourceNotFoundEvent extends LoadEvent {
		
		static public const RESOURCE_NOT_FOUND:String = "resourceNotFound";
		
		public function ResourceNotFoundEvent( event:Event, loader:ILoader = null )
		{
			super( RESOURCE_NOT_FOUND, event, loader );
		}
		
		override public function clone():Event
		{
			return new ResourceNotFoundEvent( this.triggerEvent, this.loader );
		}
		
	}
	
}
