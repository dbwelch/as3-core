/**
	<p>Implementation of the interfaces defined for the DOM events module.</p>
*/
package com.ffsys.w3c.dom.events
{
	import flash.events.Event;
	import flash.events.EventPhase;
	
	import org.w3c.dom.events.DOMEvent;
	import org.w3c.dom.events.EventTarget;
	
	/**
	* 	The EventImpl interface is used to provide contextual
	* 	information about an event to the handler processing
	* 	the event. An object which implements the EventImpl
	* 	interface is generally passed as the first parameter
	* 	to an event handler. More specific context information
	* 	is passed to event handlers by deriving additional
	* 	interfaces from EventImpl which contain information
	* 	directly relating to the type of event they accompany.
	* 
	* 	These derived interfaces are also implemented by the
	* 	object passed to the event listener.
	*/
	public class EventImpl extends Object
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
		
		/**
		* 	An error event type.
		*/
		public static const ERROR:String = "error";
		
		/**
		* 	An unload event type.
		*/
		public static const UNLOAD:String = "unload";
		
		/**
		* 	An load event type.
		*/
		public static const LOAD:String = "load";
		
		/**
		* 	A select event type.
		*/
		public static const SELECT:String = "select";
		
		/**
		* 	An abort event type.
		*/
		public static const ABORT:String = "abort";
		
		private var _target:EventTarget;
		private var _currentTarget:EventTarget;
		private var _eventPhase:uint;
		private var _timestamp:Date;
		private var _trusted:Boolean;
		private var _type:String;
		private var _bubbles:Boolean;
		private var _cancelable:Boolean;
		
		/**
		* 	Creates a <code>EventImpl</code> instance.
		* 
		* 	@param type The type of the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is cancelable.
		*/
		public function EventImpl(
			type:String = null,
			bubbles:Boolean = false,
			cancelable:Boolean = false ):void
		{
			_timestamp = new Date();
			super();
			initEvent( type, bubbles, cancelable );
		}
		
		/**
		* 	Initializes an event.
		*/
		public function initEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean ):void
		{
			setType( type );
			setBubbles( bubbles );
			setCancelable( cancelable );			
		}
		
		/**
		* 	The event phase.
		*/
		public function get eventPhase():uint
		{
			return _eventPhase;
		}
		
		/**
		* 	The type of this event.
		*/
		public function get type():String
		{
			return _type;
		}
		
		/**
		*	@private
		*/
		internal function setType( type:String ):void
		{
			_type = type;
		}
		
		/**
		* 	Determines whether this event bubbles.
		*/
		public function get bubbles():Boolean
		{
			return _bubbles;
		}
		
		/**
		*	@private
		*/
		internal function setBubbles( bubbles:Boolean ):void
		{
			_bubbles = bubbles;
		}
		
		/**
		* 	Determines wheter this event is cancelable.
		*/
		public function get cancelable():Boolean
		{
			return _cancelable;
		}
		
		/**
		*	@private
		*/
		internal function setCancelable( cancelable:Boolean ):void
		{
			_cancelable = cancelable;
		}
		
		/**
		* 	The target for the event.
		*/
		public function get target():EventTarget
		{
			return _target;
		}
		
		/**
		* 	The current target for the event.
		*/
		public function get currentTarget():EventTarget
		{
			return _currentTarget;
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
		public function stopPropagation():void
		{
			//
		}
		
		/**
		* 	Stops propagation of this event immediately.
		*/
		public function stopImmediatePropagation():void
		{
			//
		}
		
		/**
		* 	Determines whether a default action has been
		* 	prevented.
		*/
		public function get defaultPrevented():Boolean
		{
			return false;
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