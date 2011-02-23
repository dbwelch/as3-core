package org.w3c.dom.html
{
	/**
	* 	Defines the contract for HTML document head
	* 	implementations.
	*/
	public interface HTMLHeadElement extends HTMLElement
	{
		/**
		* 	A profile for the document head.
		*/
		function get profile():String;
		function set profile( profile:String ):void;
	}
}