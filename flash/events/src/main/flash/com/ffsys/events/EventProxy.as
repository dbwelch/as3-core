package com.ffsys.events {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	*	Utility class for dispatching events in the scope of
	*	a target <code>IEventDispatcher</code> instance.
	*	
	*	This provides a central point for classes
	*	that extend <code>Event</code> that need to provide
	*	static methods that can dispatch an event in the scope
	*	of a given <code>IEventDispatcher</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.12.2007
	*/
	public class EventProxy extends Object {
		
		/**
		*	@private
		*/
		public function EventProxy()
		{
			super();
		}
		
		/**
		*	Dispatches an <code>Event</code> in the scope of a
		*	target <code>IEventDispatcher</code>.
		*/
		static public function dispatchEventProxy(
			proxy:IEventDispatcher,
			event:Event ):void
		{
			proxy.dispatchEvent( event );
		}
	}
}