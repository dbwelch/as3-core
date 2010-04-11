package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Event dispatched when the cumulative size for a collection
	*	of external resources has been determined.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class CumulativeSizeCompleteEvent extends LoadEvent
		implements IBytesTotal {
			
		static public const CUMULATIVE_SIZE_COMPLETE:String = "cumulativeSizeComplete";
		
		private var _bytesTotal:uint;

		public function CumulativeSizeCompleteEvent(
			event:Event,
			loader:ILoader,
			bytesTotal:uint )
		{
			super( CUMULATIVE_SIZE_COMPLETE, event, loader );
			_bytesTotal = bytesTotal;
		}
		
		public function set bytesTotal( val:uint ):void
		{
			_bytesTotal = val;
		}
		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		override public function clone():Event
		{
			return new CumulativeSizeCompleteEvent( triggerEvent, loader, bytesTotal );
		}				
		
	}
	
}
