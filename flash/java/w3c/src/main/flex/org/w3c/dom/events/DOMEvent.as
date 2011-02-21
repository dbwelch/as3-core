/**
	<p>Defines the interfaces for the DOM events module.</p>
*/
package org.w3c.dom.events
{
	
	/**
	* 	The DOMEvent interface is used to provide contextual
	* 	information about an event to the handler processing
	* 	the event. An object which implements the DOMEvent
	* 	interface is generally passed as the first parameter
	* 	to an event handler. More specific context information
	* 	is passed to event handlers by deriving additional
	* 	interfaces from DOMEvent which contain information
	* 	directly relating to the type of event they accompany.
	* 
	* 	These derived interfaces are also implemented by the
	* 	object passed to the event listener.
	*/
	public interface DOMEvent
	{
		//
		
		/*
		public static final short	AT_TARGET	2
		public static final short	BUBBLING_PHASE	3
		public static final short	CAPTURING_PHASE 1
		*/
	}
}