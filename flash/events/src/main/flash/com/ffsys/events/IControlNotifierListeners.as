package com.ffsys.events {
	
	/**
	*	Describes the contract for instances that can
	*	add and remove their stored listeners from the core
	*	<code>Notifier</code>.
	*	
	*	@see com.ffsys.events.IControlListeners
	*	@see com.ffsys.events.Notifier
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IControlNotifierListeners {
		
		/**
		*	Adds all filtered events to the global
		*	<code>Notifier</code>.
		*/
		function addNotifierListeners():void;
		
		/**
		*	Removes all events in an <code>EventTable</code>
		*	from the global <code>Notifier</code>.
		*/
		function removeNotifierListeners():void;
	}
}