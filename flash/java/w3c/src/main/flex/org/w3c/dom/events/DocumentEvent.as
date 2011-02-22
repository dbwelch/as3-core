package org.w3c.dom.events
{
	/**
	* 	The DocumentEvent interface provides a mechanism
	* 	by which the user can create an Event object of a
	* 	type supported by the implementation. If the feature
	* 	"Events" is supported by the Document object, the
	* 	DocumentEvent interface must be implemented on the
	* 	same object. Language-specific type casting may be required.
	*/
	public interface DocumentEvent
	{
		/**
		* 	Creates an event object of the type specified.
		* 
		* 	@param eventInterface The eventInterface parameter
		* 	specifies the name of the DOM Events interface to
		* 	be supported by the created event object, e.g.
		* 	"Event", "MouseEvent", "MutationEvent", and so on.
		* 	If the Event is to be dispatched via the
		* 	EventTarget.dispatchEvent() method, the appropriate
		* 	event initialization method must be called after
		* 	creation in order to initialize the Event's values.
		* 
		* 	<p>Example: A content author wishing to synthesize some
		* 	kind of UIEvent would invoke DocumentEvent.createEvent("UIEvent").
		* 	The UIEvent.initUIEvent() method could then be called
		* 	on the newly created UIEvent object to set the specific
		* 	type of user interface event to be dispatched, scroll
		* 	for example, and set its context information, e.g. UIEvent.detail.</p>
		* 
		* 	<p>If the Event is to be dispatched via the
		* 	dispatchEvent method the appropriate event
		* 	init method must be called after creation
		* 	in order to initialize the Event's values.
		* 	As an example, a user wishing to synthesize
		* 	some kind of UIEvent would call createEvent with
		* 	the parameter "UIEvents". The initUIEvent method
		* 	could then be called on the newly created UIEvent
		* 	to set the specific type of UIEvent to be dispatched
		* 	and set its context information. The createEvent method
		* 	is used in creating Events when it is either inconvenient
		* 	or unnecessary for the user to create an Event themselves.</p>
		* 
		* 	<p>In cases where the implementation provided Event is
		* 	insufficient, users may supply their own Event
		* 	implementations for use with the dispatchEvent method.</p>
		* 
		* 	<p><strong>Warning:</strong> For security reasons, events generated using
		* 	DocumentEvent.createEvent("Event") must have a trusted
		* 	attribute value of false.</p>
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: Raised if
		* 	the implementation does not support the type of
		* 	Event interface requested.
		* 
		* 	@return The newly created Event.
		*/
		function createEvent( eventInterface:String ):DOMEvent;
	}
}