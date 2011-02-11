package org.w3c.dom
{
	/**
	* 	Represents a text node.
	*/
	public interface Text extends CharacterData
	{
		/**
		* 	TODO
		*/
		function get isElementContentWhitespace():Boolean;
		
		/**
		*	TODO
		*/
		function get wholeText():String;
		
		/**
		* 	TODO
		*/
		function splitText( offset:Number ):Text;
		
		/**
		* 	TODO
		*/
		function replaceWholeText( content:String ):Text;
	}
}