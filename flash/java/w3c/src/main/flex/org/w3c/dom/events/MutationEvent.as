package org.w3c.dom.events
{
	import org.w3c.dom.Node;
	
	/**
	* 	This module defines the feature MutationEvents 3.0
	* 	and depends on the feature Events 3.0.
	* 
	* 	The mutation and mutation name event modules are
	* 	designed to allow notification of any changes to
	* 	the structure of a document, including attribute, text,
	* 	or name modifications. It may be noted that none of
	* 	the event types associated with the modules are designated
	* 	as cancelable. This stems from the fact that it is very
	* 	difficult to make use of existing DOM interfaces which
	* 	cause document modifications if any change to the document
	* 	might or might not take place due to cancelation of the
	* 	resulting event. Although this is still a desired capability,
	* 	it was decided that it would be better left until the
	* 	addition of transactions into the DOM.
	* 
	* 	Many single modifications of the tree can cause multiple
	* 	mutation events to be dispatched. Rather than attempt to
	* 	specify the ordering of mutation events due to every possible
	* 	modification of the tree, the ordering of these events is
	* 	left to the implementation.
	* 
	* 	<p><strong>Warning:</strong> The MutationEvent interface was introduced
	* 	in DOM Level 2 Events, but has not yet been completely
	* 	and interoperably implemented across user agents. In addition,
	* 	there have been critiques that the interface, as designed,
	* 	introduces a performance and implementation challenge. A new
	* 	specification is under development with the aim of addressing
	* 	the use cases that mutation events solves, but in more performant
	* 	manner. Thus, this specification describes mutation events for
	* 	reference and completeness of legacy behavior, but deprecates the
	* 	use of both the MutationEvent interface and the MutationNameEvent interface.</p>
	*/
	public interface MutationEvent extends DOMEvent
	{
		/**
		* 	A node related to the mutation.
		*/
		function get relatedNode():Node;
		
		/**
		* 	A previous value.
		*/
		function get prevValue():String;
		
		/**
		* 	A new value.
		*/
		function get newValue():String;
		
		/**
		* 	An attribute name.
		*/
		function get attrName():String;
		
		/**
		* 	An attribute change detail.
		*/
		function get attrChange():int;
		
		/**
		* 	Initializes a mutation event.
		* 
		* 	@param type The type for the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is
		* 	cancelable.
		* 	@param relatedNode A related node.
		* 	@param prevValue A previous value.
		* 	@param newValue A new value.
		* 	@param attrName An attribute name.
		* 	@param attrChange An attribute change detail.
		*/
		function initMutationEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			relatedNode:Node,
			prevValue:String,
			newValue:String,
			attrName:String,
			attrChange:int ):void;
	}
}