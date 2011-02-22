package org.w3c.dom.events
{
	import flash.events.EventPhase;	

	/**
	* 	Represents the event phase types.
	*/
	public class PhaseType extends Object
	{
		/**
		* 	Represents the capturing phase.
		*/
		public static const CAPTURING_PHASE:uint = EventPhase.CAPTURING_PHASE;
		
		/**
		* 	Represents the at target phase.
		*/
		public static const AT_TARGET:uint = EventPhase.AT_TARGET;
		
		/**
		* 	Represents the bubbling phase.
		*/
		public static const BUBBLING_PHASE:uint = EventPhase.BUBBLING_PHASE;		
	}
}