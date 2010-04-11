package com.ffsys.events {
	
	import flash.utils.Dictionary;
	
	/**
	*	Describes the contract for instances that maintain
	*	a table of references between event types and 
	*	listener functions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IEventTable
		extends IEventElement {
		
		/**
		*	The <code>Dictionary</code> used to store
		*	a lookup between the event type and the
		*	corresponding listener method.	
		*/
		function get table():Dictionary;
		
		/**
		*	Registers a listener for a given event type.
		*	
		*	@param eventType The event type.
		*	@param listener The listener for the event type.
		*/
		function addEventTypeListener(
			eventType:String,
			listener:Function ):void;
		
		/**
		*	Gets the listener for an event type.
		*	
		*	@param eventType The event type.
		*	
		*	@return The listener registered for the event type.
		*/
		function getEventTypeListener(
			eventType:String ):Function;
		
		/**
		*	Removes a listener for a given event type.
		*	
		*	@param eventType The event type used to
		*	register the listener.
		*/
		function removeEventTypeListener(
			eventType:String ):void;
	}
}