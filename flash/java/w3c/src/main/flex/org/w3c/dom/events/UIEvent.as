package org.w3c.dom.events
{
	import org.w3c.dom.views.AbstractView;
	
	/**
	* 	This module defines the feature UIEvents 3.0
	* 	and depends on the features Events 3.0 and Views 2.0.
	* 
	* 	The User Interface event module contains basic event
	* 	types associated with user interfaces and document manipulation.
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
			view:AbstractView,
			detail:int ):void;
		
		/**
		* 	A view associated with this event.
		*/
		function get view():AbstractView;
		
		/**
		* 	The detail for this event.
		*/
		function get detail():int;
	}
}