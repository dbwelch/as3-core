package org.w3c.dom.events
{
	import org.w3c.dom.views.VisualResource;	
	
	/**
	* 	Focus related events.
	*/
	public interface FocusEvent extends UIEvent
	{	
		/**
		* 	A related target for this event.
		*/
		function get relatedTarget():EventTarget;
		
		/**
		* 	Initializes a focus event.
		* 
		* 	@param type The type for the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is
		* 	cancelable.
		* 	@param view The associated view.
		* 	@param detail A detail for the event.
		* 	@param relatedTarget A related target
		* 	for the event.
		*/
		function initFocusEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean, 
			view:VisualResource,
			detail:int,
			relatedTarget:EventTarget ):void;
	}
}