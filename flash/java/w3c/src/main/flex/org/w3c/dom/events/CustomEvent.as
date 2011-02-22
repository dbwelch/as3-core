package org.w3c.dom.events
{
	
	/**
	* 	The CustomEvent interface is the recommended
	* 	interface for application-specific event types.
	* 
	* 	Unlike the Event interface, it allows applications
	* 	to provide contextual information about the event type.
	* 
	* 	Application-specific event types should use a prefix
	* 	string on the event type name to avoid clashes with
	* 	future general-purpose event types.
	* 
	* 	To create an instance of the CustomEvent interface,
	* 	use the DocumentEvent.createEvent("CustomEvent") method call.
	*/
	public interface CustomEvent extends DOMEvent
	{
		/**
		* 	The detail data for the custom event.
		*/
		function get detail():Object;
		
		/**
		* 	Initializes a custom event.
		* 
		* 	@param type The event type.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event can be cancelled.
		* 	@param detail Detail data for the custom event.
		*/
		function initCustomEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			detail:Object ):void;
	}
}