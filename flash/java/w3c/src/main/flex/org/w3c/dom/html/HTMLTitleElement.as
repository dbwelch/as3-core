package org.w3c.dom.html
{
	/**
	* 	Defines the contract for HTML document title
	* 	implementations.
	*/
	public interface HTMLTitleElement extends HTMLElement
	{		
		/**
		* 	The text for this title.
		*/
		function get text():String;
		function set text( text:String ):void;
	}
}