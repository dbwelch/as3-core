package com.ffsys.events {
	
	import flash.events.Event;
	
	/**
	*	Abstract super class for all events.
	*	
	*	Allows for an associated trigger <code>Event</code>
	*	to be associated with this event and provides the
	*	core functionality for allowing the default behaviour of
	*	an event to be prevented.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class AbstractEvent extends Event {
		
		/**
		*	@private 
		*	
		*	Declared to allow storage of a flag indicating whether
		*	the default behaviour has been cancelled or not.
		*/
		protected var _defaultPrevented:Boolean;
		
		/**
		*	@private
		*	
		*	The source event that triggered this event
		*	if available.
		*/
		private var _triggerEvent:Event;
		
		/**
		*	Creates an <code>AbstractEvent</code> instance.
		*	
		*	@param type The <code>type</code> for this event.
		*	@param triggerEvent An <code>Event</code> that
		*	triggered this event.
		*/
		public function AbstractEvent(
			type:String,
			triggerEvent:Event = null )
		{
			super( type );
			this.triggerEvent = triggerEvent;
		}
		
		/**
		*	Determines whether the default behaviour has
		*	been prevented.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the default behaviour of this event has been prevented.
		*/
		override public function isDefaultPrevented():Boolean
		{
			return _defaultPrevented;
		}
		
		/**
		*	Prevents the default behaviour of this event.	
		*/
		override public function preventDefault():void
		{
			_defaultPrevented = true;
		}
		
		/**
		*	An <code>Event</code> that triggered this event.
		*/
		public function set triggerEvent( val:Event ):void
		{
			_triggerEvent = val;
		}
		
		public function get triggerEvent():Event
		{
			return _triggerEvent;
		}
	}	
}