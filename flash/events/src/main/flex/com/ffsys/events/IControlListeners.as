package com.ffsys.events {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for instances that can
	*	add and remove the listeners stored in an
	*	IEventTable passing them through an IEventFilters
	*	instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IControlListeners {
		
		/**
		*	Adds the listeners associated with an
		*	<code>IEventFilters</code> instance to a
		*	target <code>IEventDispatcher</code>.
		*	
		*	This method adds only filtered events.
		*	
		*	@param target The target event dispatcher.
		*/
		function addListeners(
			target:IEventDispatcher = null ):void;
			
		/**
		*	Removes the listeners associated with an
		*	<code>IEventFilters</code> instance to a
		*	target <code>IEventDispatcher</code>.
		*	
		*	This method removes all listeners stored
		*	in the <code>EventTable</code> not just
		*	the filtered events.
		*	
		*	@param target The target event dispatcher.
		*/		
		function removeListeners(
			target:IEventDispatcher = null ):void;
	}
}