package org.xml.sax.helpers
{
	import org.xml.sax.*;
	
	/**
	* 	Base class for deriving an XML filter.
	* 
	* 	This class is designed to sit between an
	* 	XMLReader and the client application's event
	* 	handlers. By default, it does nothing but pass
	* 	requests up to the reader and events on to the handlers
	* 	unmodified, but subclasses can override specific methods
	* 	to modify the event stream or the configuration requests
	* 	as they pass through.
	*/
	public class XMLFilterImpl extends Object
		implements	ContentHandler,
					DTDHandler,
					EntityResolver,
					ErrorHandler,
					XMLFilter
	{
		/**
		* 	Creates an <code>XMLFilterImpl</code> instance.
		*/
		public function XMLFilterImpl()
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