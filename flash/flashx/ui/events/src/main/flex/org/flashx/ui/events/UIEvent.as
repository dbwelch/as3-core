package org.flashx.ui.events {
	
	import flash.events.Event;
	import org.flashx.events.AbstractEvent;
	
	/**
	*	Abstract super class for ui events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public class UIEvent extends AbstractEvent {
		
		/**
		*	Creates a <code>UIEvent</code> instance.
		* 
		* 	@param type The type of event.
		*/
		public function UIEvent(
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
			throw new Error( "You must override the clone method in your concrete event class." );
		}
	}
}