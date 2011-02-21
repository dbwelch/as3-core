package org.w3c.dom.events
{
	
	/**
	* 	The UIEvent interface provides specific 
	* 	contextual information associated with
	* 	User Interface events.
	*/
	public interface UIEvent extends DOMEvent
	{
		
		/**
		* 	
		*/
		function get detail():int;
	}
}