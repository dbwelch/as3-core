package org.w3c.dom.events
{
	/**
	* 	The EventListener interface is the primary
	* 	method for handling events. Users implement
	* 	the EventListener interface and register
	* 	their listener on an EventTarget using
	* 	the addEventListener method. The users
	* 	should also remove their EventListener
	* 	from its EventTarget after they have
	* 	completed using the listener.
	* 
	* 	When a Node is copied using the cloneNode
	* 	method the EventListeners attached to
	* 	the source Node are not attached
	* 	to the copied Node. If the user wishes
	* 	the same EventListeners to be added to
	* 	the newly created copy the user must
	* 	add them manually.
	*/
	public interface EventListener
	{
		/**
		* 	This method is called whenever an event 
		* 	occurs of the type for which the EventListener
		* 	interface was registered.
		* 
		* 	@param The Event contains contextual
		* 	information about the event. It also
		* 	contains the stopPropagation and 
		* 	preventDefault methods which are used
		* 	in determining the event's flow and default action.
		*/
		function handleEvent( evt:DOMEvent ):void;
	}
}