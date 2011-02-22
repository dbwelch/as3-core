package org.w3c.dom.events
{
	import org.w3c.dom.views.VisualResource;
	
	/**
	* 	The UIEvent interface provides specific 
	* 	contextual information associated with
	* 	User Interface events.
	*/
	public interface UIEvent extends DOMEvent
	{
		
		/**
		* 	Initializes a UI event.
		* 
		* 	@param type The type for the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is
		* 	cancelable.
		* 	@param view The associated view.
		* 	@param detail A detail for the event.
		*/
		function initUIEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			view:VisualResource,
			detail:int ):void;
		
		/**
		* 	A view associated with this event.
		*/
		function get view():VisualResource;
		
		/**
		* 	The detail for this event.
		*/
		function get detail():int;
	}
}