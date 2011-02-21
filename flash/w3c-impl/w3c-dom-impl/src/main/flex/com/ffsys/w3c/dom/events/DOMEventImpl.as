/**
	<p>Implementation of the interfaces defined for the DOM events module.</p>
*/
package com.ffsys.w3c.dom.events
{
	import flash.events.Event;
	import flash.events.EventPhase;
	
	import org.w3c.dom.events.DOMEvent;
	
	/**
	* 	The DOMEventImpl interface is used to provide contextual
	* 	information about an event to the handler processing
	* 	the event. An object which implements the DOMEventImpl
	* 	interface is generally passed as the first parameter
	* 	to an event handler. More specific context information
	* 	is passed to event handlers by deriving additional
	* 	interfaces from DOMEventImpl which contain information
	* 	directly relating to the type of event they accompany.
	* 
	* 	These derived interfaces are also implemented by the
	* 	object passed to the event listener.
	*/
	public class DOMEventImpl extends Event
		implements DOMEvent
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
		
		private var _timestamp:Date;
		private var _trusted:Boolean;
		
		/**
		* 	Creates a <code>DOMEventImpl</code> instance.
		* 
		* 	@param type The type of the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is cancelable.
		*/
		public function DOMEventImpl(
			type:String,
			bubbles:Boolean = false,
			cancelable:Boolean = false ):void
		{
			_timestamp = new Date();
			super( type, bubble, cancelable );
		}
		
		/**
		* 	Initializes an event.
		*/
		public function initEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean ):void
		{
			
		}
		
		/**
		* 	The target for the event.
		*/
		public function getTarget():EventTarget
		{
			return EventTarget( this.target );
		}
		
		/**
		* 	The current target for the event.
		*/
		public function getCurrentTarget():EventTarget
		{
			return EventTarget( this.currentTarget );
		}
		
		/**
		* 	A timestamp generated when this event
		* 	was created.
		*/
		public function get timestamp():Date
		{
			return _timestamp;
		}
		
		/**
		* 	Stops propagation of this event.
		*/
		override public function stopPropagation():void
		{
			super.stopPropagation();
		}
		
		/**
		* 	Stops propagation of this event immediately.
		*/
		override public function stopImmediatePropagation():void
		{
			super.stopImmediatePropagation();
		}
		
		/**
		* 	Determines whether a default action has been
		* 	prevented.
		*/
		public function get defaultPrevented():Boolean
		{
			return isDefaultPrevented();
		}
		
		/**
		* 	Prevents the default behaviour of this event.
		*/
		override public function preventDefault():void
		{
			super.preventDefault();
		}
		
		/**
		* 	Determines whether this event is trusted.
		*/
		public function get trusted():Boolean
		{
			return _trusted;
		}
	}
}