package com.ffsys.di
{

	public interface IBeanParser
	{
		/**
		* 	The mapping between valid expressions and the corresponding
		* 	class.
		*/
		function get expressions():Object;
		
		/**
		* 	The bean document to parse into.
		*/
		function get document():IBeanDocument;
		function set document( value:IBeanDocument ):void;
		
		/**
		* 	Parses the <code>text</code> and returns the 
		* 	encapsulated document after parsing has taken place.
		* 
		* 	@param text The text for parsed.
		* 
		* 	@return A bean document.
		*/
		function parse( text:String ):IBeanDocument;
		
		/**
		* 	The delimiter to use when parsing array values.
		* 
		* 	The default value is a vertical bar.
		*/
		function get delimiter():String;
		function set delimiter( value:String ):void;		
	}
}