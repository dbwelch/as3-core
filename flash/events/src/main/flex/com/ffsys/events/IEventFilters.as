package com.ffsys.events {
	
	/**
	*	Describes the contract for instances that maintain
	*	a collection of event type filters.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IEventFilters
		extends	IEventElement,
				IEventTableReference {
		
		/**
		*	Registers an event type filter.
		*	
		*	@param eventType The event type to filter.
		*/
		function addEventFilter( eventType:String ):void;
		
		/**
		*	Removes an event type filter.
		*	
		*	@param eventType The event type to remove from
		*	the list of event filters.
		*/
		function removeEventFilter( eventType:String ):void;
		
		/**
		*	Gets an <code>IEventTable</code> containing only
		*	the filtered event types.
		*	
		*	@return The filtered event table.
		*/
		function getFilteredEventTable():IEventTable;
		
		/**
		*	An <code>Array</code> of all registered filters.
		*/
		function get filters():Array;
	}
}