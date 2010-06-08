package com.ffsys.swat.events {
	
	import flash.events.Event;
	
	/**
	*	Represents an event dispatched when runtime assets are available.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class RslEvent extends Event {
		
		public static const LIBRARY_LOADED:String = "rslLibraryLoaded";
		
		/**
		*	Creates a <code>RslEvent</code> instance.
		*/
		public function RslEvent(
			type:String )
		{
			super( type );
		}

		/**
		*	Creates a clone of this event.
		*	
		*	@return The cloned event.	
		*/
		override public function clone():Event
		{
			var event:RslEvent = new RslEvent( type );
			return event;
		}
	}
}