package org.flashx.utils.history {
	
	import flash.events.Event;
	
	import org.flashx.events.AbstractEvent;
	
	/**
	*	Encapsulates events dispatched by
	*	<code>History</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.09.2007
	*/
	public class HistoryEvent extends AbstractEvent {
		
		/**
		*	Dispatched when a <code>History</code> instance
		*	changes it's position.
		*/
		static public const CHANGE:String =
			"historyChange";
		
		/**
		*	Creates	a <code>HistoryEvent</code> instance
		*	of the given type.
		*/
		public function HistoryEvent( type:String )
		{
			super( type, null );
		}
	}
}