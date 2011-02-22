/**
	<p>Defines the interfaces for the DOM events module.</p>
*/
package org.w3c.dom.events
{
	import flash.events.Event;
	import flash.events.EventPhase;	
	
	/*
	
	
	
	Event Type	Sync / Async	Bubbling phase	Trusted proximal event target types	DOM interface	Cancelable	Default Action
	abort	Sync	No	Element	Event	No	none
	blur	Sync	No	Element	FocusEvent	No	none
	click	Sync	Yes	Element	MouseEvent	Yes	DOMActivate event
	compositionstart	Sync	Yes	Element	CompositionEvent	Yes	Launch text composition system
	compositionupdate	Sync	Yes	Element	CompositionEvent	No	none
	compositionend	Sync	Yes	Element	CompositionEvent	No	none
	dblclick	Sync	Yes	Element	MouseEvent	No	none
	DOMActivate	Sync	Yes	Element	UIEvent	Yes	none
	DOMAttributeNameChanged	Sync	Yes	Element	MutationNameEvent	No	none
	DOMAttrModified	Sync	Yes	Element	MutationEvent	No	none
	DOMCharacterDataModified	Sync	Yes	Text, Comment, CDATASection, ProcessingInstruction	MutationEvent	No	none
	DOMElementNameChanged	Sync	Yes	Element	MutationNameEvent	No	none
	DOMFocusIn	Sync	Yes	Element	FocusEvent	No	none
	DOMFocusOut	Sync	Yes	Element	FocusEvent	No	none
	DOMNodeInserted	Sync	Yes	Element, Attr, Text, Comment, CDATASection, DocumentType, EntityReference, ProcessingInstruction	MutationEvent	No	none
	DOMNodeInsertedIntoDocument	Sync	No	Element, Attr, Text, Comment, CDATASection, DocumentType, EntityReference, ProcessingInstruction	MutationEvent	No	none
	DOMNodeRemoved	Sync	Yes	Element, Attr, Text, Comment, CDATASection, DocumentType, EntityReference, ProcessingInstruction	MutationEvent	No	none
	DOMNodeRemovedFromDocument	Sync	No	Element, Attr, Text, Comment, CDATASection, DocumentType, EntityReference, ProcessingInstruction	MutationEvent	No	none
	DOMSubtreeModified	Sync	Yes	defaultView, Document, DocumentFragment, Element, Attr	MutationEvent	No	none
	error	Async	No	Element	Event	No	none
	focus	Sync	No	Element	FocusEvent	No	none
	focusin	Sync	Yes	Element	FocusEvent	No	none
	focusout	Sync	Yes	Element	FocusEvent	No	none
	keydown	Sync	Yes	Element	KeyboardEvent	Yes	Varies: textInput event; launch text composition system; blur and focus events; DOMActivate event; other event
	keypress	Sync	Yes	Element	KeyboardEvent	Yes	Varies: textInput event; launch text composition system; blur and focus events; DOMActivate event; other event
	keyup	Sync	Yes	Element	KeyboardEvent	Yes	none
	load	Async	No	defaultView, Document, Element	Event	No	none
	mousedown	Sync	Yes	Element	MouseEvent	Yes	none
	mouseenter	Sync	No	Element	MouseEvent	No	none
	mouseleave	Sync	No	Element	MouseEvent	No	none
	mousemove	Sync	Yes	Element	MouseEvent	Yes	none
	mouseout	Sync	Yes	Element	MouseEvent	Yes	none
	mouseover	Sync	Yes	Element	MouseEvent	Yes	none
	mouseup	Sync	Yes	Element	MouseEvent	Yes	none
	resize	Sync	No	defaultView, Document	UIEvent	No	none
	scroll	Async	No / Yes	defaultView, Document, Element	UIEvent	No	none
	select	Sync	Yes	Element	Event	No	none
	textInput	Sync	Yes	Element	TextEvent	Yes	none
	unload	Sync	No	defaultView, Document, Element	Event	No	none
	wheel	Async	Yes	defaultView, Document, Element	WheelEvent	Yes	Scroll (or zoom) the document	
	
	
	*/
	
	/**
	* 	The Event interface is used to provide contextual information
	* 	about an event to the listener processing the event.
	* 
	* 	An object which implements the Event interface shall be passed
	* 	as the parameter to an EventListener. The object passed to the
	* 	event listener may also implement derived interfaces that
	* 	provide access to information directly relating to the type of
	* 	event they represent.
	*
	* 	To create an instance of the Event interface, use the
	* 	DocumentEvent.createEvent("Event") method call.
	*/
	public interface DOMEvent
	{
		/**
		* 	Initializes this event.
		* 
		* 	@param type The type for the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is
		* 	cancelable.
		*/
		function initEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean ):void;
		
		/**
		* 	The target for the event.
		*/
		function get target():EventTarget;
		
		/**
		* 	The current target for the event.
		*/
		function get currentTarget():EventTarget;
		
		/**
		* 	The type of the event.
		*/
		function get type():String;
		
		/**
		* 	The event phase.
		*/
		function get eventPhase():uint;
		
		/**
		* 	Whether this event bubbles.
		*/
		function get bubbles():Boolean;
		
		/**
		* 	Whether this event may be cancelled.
		*/
		function get cancelable():Boolean;
		
		/**
		* 	A timestamp generated when this event
		* 	was created.
		*/
		function get timestamp():Date;
		
		/**
		* 	Stops propagation of this event.
		*/
		function stopPropagation():void;
		
		/**
		* 	Stops propagation of this event immediately.
		*/
		function stopImmediatePropagation():void;
		
		/**
		* 	Determines whether a default action has been
		* 	prevented.
		*/
		function get defaultPrevented():Boolean;
		
		/**
		* 	Determines whether this event is trusted.
		*/
		function get trusted():Boolean;
	}
}