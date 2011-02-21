package org.xml.sax.helpers
{
	import org.xml.sax.*;

	/**
	* 	Default base class for SAX2 event handlers.
	* 
	* 	<p>This class is available as a convenience
	* 	base class for SAX2 applications: it provides
	* 	default implementations for all of the callbacks
	* 	in the four core SAX2 handler classes:</p>
	* 
	* 	<ul>
	* 		<li>EntityResolver</li>
	* 		<li>DTDHandler</li>
	* 		<li>ContentHandler</li>
	* 		<li>ErrorHandler</li>
	* 	</ul>
	* 
	* 	<p>Application writers can extend this class when
	* 	they need to implement only part of an interface;
	* 	parser writers can instantiate this class to provide
	* 	default handlers when the application has not
	* 	supplied its own.</p>
	* 
	* 	<p>This class replaces the deprecated SAX1
	* 	HandlerBase class.</p>
	*/
	public class DefaultHandler extends Object
		implements 	ContentHandler,
					DTDHandler,
					EntityResolver,
					ErrorHandler
	{
		/**
		* 	Creates a <code>DefaultHandler</code> instance.
		*/
		public function DefaultHandler()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function characters( ch:String, start:int, length:int ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startElement(
			uri:String,
			localName:String,
			qname:String,
			atts:Attributes ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endElement(
			uri:String,
			localName:String,
			qname:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startPrefixMapping(
			prefix:String, uri:String ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/
		public function endPrefixMapping(
			prefix:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function ignorableWhitespace(
			ch:String, start:int, length:int ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function processingInstruction(
			target:String, data:String ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/
		public function setDocumentLocator(
			locator:Locator ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/	
		public function skippedEntity( name:String ):void
		{
			//TODO
		}		
	}
}