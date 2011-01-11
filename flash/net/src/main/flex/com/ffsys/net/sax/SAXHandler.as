package com.ffsys.net.sax
{
	
	public class SAXHandler extends Object
	{
		/**
		* 	Creates a <code>SAXHandler</code> instance.
		*/
		public function SAXHandler()
		{
			super();
		}
		
		public function beginDocument( token:SAXToken ):void
		{
			trace("[BEGIN DOCUMENT] SAXHandler::beginDocument()", token.name, token.type );
		}
		
		public function shouldSkipElement( token:SAXToken ):Boolean
		{
			return false;
		}
		
		public function startElement( token:SAXToken ):void
		{
			trace("[START ELEMENT] SAXHandler::startElement()", token.name, token.type );
		}
		
		public function doWithProcessingInstruction( token:SAXToken ):void
		{
			trace("[PROCESSING-INSTRUCTION] SAXHandler::doWithProcessingInstruction()", token.name, token.type );
		}
		
		public function endElement( token:SAXToken ):void
		{
			trace("[END ELEMENT] SAXHandler::endElement()", token.name, token.type );
		}
		
		public function endDocument( token:SAXToken ):void
		{
			trace("[END DOCUMENT] SAXHandler::endDocument()", token.name, token.type );
		}
	}
}