package org.flashx.ui.events
{
	import flash.events.Event;
	
	/**
	*	Encapsulates selection related events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public class SelectionEvent extends UIEvent
	{
		/**
		* 	Event dispatched when a selection has been changed.
		*/
		public static const CHANGED:String = "selectionChanged";
	
		/**
		*	Creates a <code>SelectionEvent</code> instance.
		* 
		* 	@param type The type of the event.
		*/
		public function SelectionEvent( type:String )
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
			return new SelectionEvent( type );
		}		
	}
}