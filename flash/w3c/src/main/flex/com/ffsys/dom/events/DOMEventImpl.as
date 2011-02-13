package com.ffsys.dom.events
{
	import com.ffsys.events.AbstractEvent;
	
	import org.w3c.dom.events.*;
	
	/**
	* 	TODO
	*/
	public class DOMEventImpl extends AbstractEvent
		implements DOMEvent
	{
		/**
		* 	The current event phase is the capturing phase.
		*/
		public static const CAPTURING_PHASE:uint = 1;
		
		/**
		* 	The event is currently being evaluated
		* 	at the target EventTarget.
		*/
		public static const AT_TARGET:uint = 2;
		
		/**
		* 	The current event phase is the bubbling phase.
		*/
		public static const BUBBLING_PHASE:uint = 3;
		
		/**
		* 	Creates a <code>DOMEventImpl</code> instance.
		*/
		public function DOMEventImpl( type:String )
		{
			super( type );
		}
	}
}