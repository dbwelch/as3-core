package org.w3c.dom.html
{
	import org.w3c.dom.Document;
	import org.w3c.dom.NodeList;
	
	/**
	* 	Defines the contract for HTML document
	* 	implementations.
	*/
	public interface HTMLDocument extends Document
	{
		
		/**
		* 	The document title.
		*/
		function get title():String;
		function set title( title:String ):void;
		
		/**
		* 	A referrer to this document.
		*/
		function get referrer():String;
		
		/**
		* 	The domain of this document.
		*/
		function get domain():String;
		
		/**
		* 	The url of this document.
		*/
		function get url():String;
		
		/**
		* 	The body content of the document.
		*/
		function get body():HTMLBodyElement;
		function set body( body:HTMLBodyElement ):void;
		
		//This property is a String and can raise an object that implements DOMException interface on setting.
		/**
		* 	A cookie for this document.
		*/
		function get cookie():String;
		function set cookie( cookie:String ):void;
		
		/**
		* 	The document images.
		*/
		function get images():HTMLCollection;
		
		/**
		* 	The document applets.
		*/
		function get applets():HTMLCollection;
		
		/**
		* 	The document links.
		*/
		function get links():HTMLCollection;
		
		/**
		* 	The document forms.
		*/
		function get forms():HTMLCollection;
		
		/**
		* 	The document anchors.
		*/
		function get anchors():HTMLCollection;
		
		/**
		* 	
		*/
		function open():void;
		
		/**
		* 	
		*/
		function close():void;
		
		/**
		* 	Writes to this document.
		* 
		* 	@param text The text to write.
		*/
		function write( text:String ):void;
		
		/**
		* 	Writes a line to this document.
		* 
		* 	@param text The text to write.
		*/
		function writeln( text:String ):void;
		
		/**
		* 	Retrieves a list of elements by tag name.
		* 
		* 	@param elementName The list of elements
		* 	to retrieve.
		* 
		* 	@return A list of the matching elements.
		*/
		function getElementsByName( elementName:String ):NodeList;
	}
}