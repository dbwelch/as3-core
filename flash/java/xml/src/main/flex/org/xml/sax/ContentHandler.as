package org.xml.sax
{
	/**
	* 	Receive notification of the logical content of a document.
	* 
	* 	<p>This is the main interface that most SAX
	* 	applications implement: if the application needs
	* 	to be informed of basic parsing events, it implements
	* 	this interface and registers an instance with the SAX
	* 	parser using the setContentHandler method. The parser
	* 	uses the instance to report basic document-related
	* 	events like the start and end of elements and character data.</p>
	* 
	* 	<p>The order of events in this interface is very important,
	* 	and mirrors the order of information in the document itself.
	* 	For example, all of an element's content (character data,
	* 	processing instructions, and/or subelements) will appear, in order,
	* 	between the startElement event and the corresponding endElement event.</p>
	* 
	* 	<p>This interface is similar to the now-deprecated SAX 1.0
	* 	DocumentHandler interface, but it adds support for Namespaces
	* 	and for reporting skipped entities (in non-validating XML processors).</p>
	* 
	* 	<p>Implementors should note that there is also a ContentHandler
	* 	class in the java.net package; that means that it's probably
	* 	a bad idea to do:</p>
	* 
	* 	<pre>import java.net.*;
	*	import org.xml.sax.*;</pre>
	* 
	* 	<p>In fact, "import ...*" is usually a sign of sloppy
	* 	programming anyway, so the user should consider this a
	* 	feature rather than a bug.</p>
	*/
	public interface ContentHandler
	{
		/**
		* 	
		*/
		function characters( ch:String, start:int, length:int ):void;
		
		/**
		* 	
		*/
		function startDocument():void;
		
		/**
		* 	
		*/
		function startElement(
			uri:String,
			localName:String,
			qname:String,
			atts:Attributes ):void;
		
		/**
		* 
		*/
		function endElement(
			uri:String,
			localName:String,
			qname:String ):void;
		
		/**
		* 	
		*/
		function startPrefixMapping(
			prefix:String, uri:String ):void;
			
		/**
		* 	
		*/
		function endPrefixMapping(
			prefix:String ):void;
		
		/**
		* 	
		*/
		function endDocument():void;
		
		/**
		* 	
		*/
		function ignorableWhitespace(
			ch:String, start:int, length:int ):void;
		
		/**
		* 
		*/
		function processingInstruction(
			target:String, data:String ):void;
			
		/**
		* 
		*/
		function setDocumentLocator(
			locator:Locator ):void;
			
		/**
		* 	
		*/	
		function skippedEntity( name:String ):void;
	}
}