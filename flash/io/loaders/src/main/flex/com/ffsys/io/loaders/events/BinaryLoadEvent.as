package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IBinaryAccess;
	import com.ffsys.io.loaders.resources.BinaryResource;
	
	/**
	*	Event dispatched when arbritrary binary data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class BinaryLoadEvent extends LoadEvent
		implements IBinaryAccess {
		
		public function BinaryLoadEvent(
			event:Event,
			loader:ILoader,
			resource:BinaryResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get bytes():ByteArray
		{
			return BinaryResource( resource ).bytes;
		}
		
		override public function clone():Event
		{
			return new BinaryLoadEvent( triggerEvent, loader, BinaryResource( resource ) );
		}		
		
	}
	
}
