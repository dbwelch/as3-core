package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Super class for all load events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public class LoadEvent extends AbstractLoadEvent {
		
		static public const DATA:String = "data";
		
		public function LoadEvent(
			type:String,
			triggerEvent:Event,
			loader:ILoader,
			resource:IResourceElement = null )
		{
			super( type, triggerEvent, loader );
			this.resource = resource;
		}
		
		override public function clone():Event
		{
			return new LoadEvent( type, triggerEvent, loader, resource );
		}
		
	}
	
}
