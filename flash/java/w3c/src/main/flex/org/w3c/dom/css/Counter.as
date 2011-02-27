package org.w3c.dom.css
{
	/**
	* 	The Counter interface is used to represent any counter
	* 	or counters function value.
	* 
	* 	This interface reflects the values in the underlying style property.
	* 	
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface Counter
	{
		/**
		* 	This attribute is used for the identifier
		* 	of the counter.
		*/
		function get identifier():String;
		
		/**
		* 	This attribute is used for the style
		* 	of the list.
		*/
		function get listStyle():String;
		
		/**
		* 	This attribute is used for the separator
		* 	of the nested counters.
		*/
		function get separator():String;
	}
}