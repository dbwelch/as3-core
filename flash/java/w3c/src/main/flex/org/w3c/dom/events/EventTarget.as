package org.w3c.dom.events
{
	import flash.events.IEventDispatcher;
	
	/**
	* 	The EventTarget interface is implemented
	* 	by all Nodes in an implementation which
	* 	supports the DOM Event Model.
	* 
	* 	Therefore, this interface can be obtained by
	* 	using binding-specific casting methods on
	* 	an instance of the Node interface. The
	* 	interface allows registration and removal
	* 	of EventListeners on an EventTarget and
	* 	dispatch of events to that EventTarget.
	*/
	public interface EventTarget extends IEventDispatcher
	{
		//
	}
}