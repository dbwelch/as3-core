package org.w3c.dom.events
{
	import org.w3c.dom.Node;
	
	/**
	* 	Represents a mutation event.
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